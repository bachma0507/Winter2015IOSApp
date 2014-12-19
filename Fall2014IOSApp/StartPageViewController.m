//
//  StartPageViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "StartPageViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "Fall2013IOSAppAppDelegate.h"

@interface StartPageViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation StartPageViewController

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize json, exhibitorsArray, speakersArray, sessionsArray, updateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    [TestFlight passCheckpoint:@"StartPage-viewed"];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"]){
        NSLog(@"First time run");
        
        [self performSegueWithIdentifier: @"eulaview" sender: self];
        
    }
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenOverlay"]){
        NSLog(@"First time view overlay");
        
        [self showTutorialOverlay];
        
    }

//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:window.bounds];
//        imageView.image = [UIImage imageNamed:@"app_instructions"];
//        imageView.backgroundColor = [UIColor whiteColor];
//        imageView.alpha = 0.6;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissHelpView:)];
//        [imageView addGestureRecognizer:tapGesture];
//        imageView.userInteractionEnabled = YES;
//        [window addSubview:imageView];
//    }
    
    
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Updating data...";
    //HUD.detailsLabelText = @"Just relax";
    HUD.mode = MBProgressHUDAnimationFade;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
    NSDate *updatetime = [NSDate date];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    if (!results || !results.count)
    {//if block begin
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Timeinterval" inManagedObjectContext:context];
        
        [newManagedObject setValue:updatetime forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        NSLog(@"You created a new updatetime object!");
    
    }
    
    else{//else block begin
        
        NSManagedObject *object = [results objectAtIndex:0];
        [object setValue:updatetime forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You updated the updatetime object from an APP RESTART!");
        
        
        
    }//else block ends

}


//- (void)dismissHelpView:(UITapGestureRecognizer *)sender {
//    UIView *helpImageView = sender.view;
//    [helpImageView removeFromSuperview];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didDisplayHelpScreen"];
//}

- (void)waitForTwoSeconds {
    sleep(6);
    NSString *MyString;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
	MyString = [dateFormatter stringFromDate:now];
    NSLog(@"Last updated: %@", MyString);
    NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
    updateLabel.text = updated;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateAllData{
    Fall2013IOSAppAppDelegate *update = [[Fall2013IOSAppAppDelegate alloc] init];
    
    [update updateAllData];
    
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"bicsi" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"bicsi.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (IBAction)buttonPressed:(id)sender {
    
    [TestFlight passCheckpoint:@"updateData-button-pressed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Updating data...";
    //HUD.detailsLabelText = @"Just relax";
    HUD.mode = MBProgressHUDAnimationFade;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(updateAllData) onTarget:self withObject:nil animated:YES];
    
    NSString *MyString;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
	MyString = [dateFormatter stringFromDate:now];
    NSLog(@"Last updated: %@", MyString);
    NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
    updateLabel.text = updated;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    
    NSManagedObject *object = [results objectAtIndex:0];
    [object setValue:now forKey:@"updatetime"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    
    NSLog(@"You updated the updatetime object from the UPDATE DATA button!");
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //NSDate *timeNow = [NSDate date];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.objects = results;
    
    if (!results || !results.count){
        NSLog(@"No results");
    }
    else{//else block begin
        
        NSManagedObject *object = [results objectAtIndex:0];
        
        NSDate *updatetime = [object valueForKey:@"updatetime"];
        
        NSString *MyString;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
        MyString = [dateFormatter stringFromDate:updatetime];
        NSLog(@"******Value of updatetime converted to string: %@", MyString);
        
        
        NSTimeInterval elapsedTime = [updatetime timeIntervalSinceNow];
        
        NSString *timeDiff = [NSString stringWithFormat:@"%f", -elapsedTime];
        
        NSLog(@"Elapsed time: %@", timeDiff);
        
        if (-elapsedTime > 86400) {
            NSLog(@"Elapsed time is greater than 24 hours.");
            
            NSString *message = @"Data has not been updated in over 24 hours. Click OK to update the data, or Cancel to cancel the update.";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Data Update Alert"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                     otherButtonTitles:@"OK",nil];
            [alertView show];
        }
        
    }
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.

    if (buttonIndex == 1) {

        //[self updateAllData];
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.labelText = @"Updating data...";
        //HUD.detailsLabelText = @"Just relax";
        HUD.mode = MBProgressHUDAnimationFade;
        [self.view addSubview:HUD];
        [HUD showWhileExecuting:@selector(updateAllData) onTarget:self withObject:nil animated:YES];
        
        NSString *MyString;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        [dateFormatter setDateFormat:@"MMM dd yyyy hh:mm a"];
        MyString = [dateFormatter stringFromDate:now];
        NSLog(@"Last updated: %@", MyString);
        NSString * updated = [NSString stringWithFormat:@"Data last updated: %@", MyString];
        updateLabel.text = updated;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Timeinterval" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        self.objects = results;
        
        NSManagedObject *object = [results objectAtIndex:0];
        [object setValue:now forKey:@"updatetime"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You updated the updatetime object from the DATA UPDATE ALERT!");


    }



}

- (IBAction)onBurger:(id)sender {
    
    if ( [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ) /* Device is iPad */
    {
    
    NSArray *images = @[
                        [UIImage imageNamed:@"surveysW15_550x550.png"],
                        [UIImage imageNamed:@"presentationsW15_600x600.png"],
                        [UIImage imageNamed:@"cecinfoW15_550x550.png"],
                        [UIImage imageNamed:@"trainingexamsW15_550x550.png"],
                        [UIImage imageNamed:@"hotelW15_550x550.png"],
                        [UIImage imageNamed:@"contactW15_550x550.png"],
                        [UIImage imageNamed:@"emailW15_550x550.png"],
//                        [UIImage imageNamed:@"sponsors"],
//                        [UIImage imageNamed:@"sessions"],
//                        [UIImage imageNamed:@"exhibitors"],
//                        [UIImage imageNamed:@"favexhibitors"],
//                        [UIImage imageNamed:@"mynotes"],
//                        [UIImage imageNamed:@"myagenda"],
                        
                        
                        
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
//                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
//                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
//                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
//                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
//                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
//                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
        
        }
    
    else{
        NSArray *images = @[
                            [UIImage imageNamed:@"surveysW15_550x550.png"],
                            [UIImage imageNamed:@"floormapsW15_550x550.png"],
                            [UIImage imageNamed:@"presentationsW15_600x600.png"],
                            [UIImage imageNamed:@"cecinfoW15_550x550.png"],
                            [UIImage imageNamed:@"trainingexamsW15_550x550.png"],
                            [UIImage imageNamed:@"committeeW15_550x550.png"],
                            [UIImage imageNamed:@"hotelW15_550x550.png"],
                            [UIImage imageNamed:@"activitiesW15_550x550.png"],
                            [UIImage imageNamed:@"contactW15_550x550.png"],
                            [UIImage imageNamed:@"emailW15_550x550.png"],
                            
                            //                        [UIImage imageNamed:@"sponsors"],
                            //                        [UIImage imageNamed:@"sessions"],
                            //                        [UIImage imageNamed:@"exhibitors"],
                            //                        [UIImage imageNamed:@"favexhibitors"],
                            //                        [UIImage imageNamed:@"mynotes"],
                            //                        [UIImage imageNamed:@"myagenda"],
                            
                            
                            
                            ];
        NSArray *colors = @[
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                            [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                            //                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                            //                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                            //                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                            ];
        
        RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithiPhoneImages:images selectedIndices:self.optionIndices borderColors:colors];
        //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
        callout.delegate = self;
        //    callout.showFromRight = YES;
        [callout show];
    }
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) /* Device is iPad */
    {
    
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    switch (index) {
        case 0:
            [self performSegueWithIdentifier:@"segueToSurveys" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"segueToPresentations" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"segueToCECInfo" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 3:
            [self performSegueWithIdentifier:@"segueToExams" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 4:
            [self performSegueWithIdentifier:@"segueToHotel" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 5:
            [self performSegueWithIdentifier:@"segueToContactUs" sender:self];
            
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        case 6:
            if ([MFMailComposeViewController canSendMail])
            {
                NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
                NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
                NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
                
                NSLog(@"Untruncated Device ID is: %@", deviceID);
                NSLog(@"Truncated Device ID is: %@", newDeviceID);
                
                
                UIDevice *currentDevice = [UIDevice currentDevice];
                NSString *model = [currentDevice model];
                NSString *systemVersion = [currentDevice systemVersion];
                
                NSArray *languageArray = [NSLocale preferredLanguages];
                NSString *language = [languageArray objectAtIndex:0];
                NSLocale *locale = [NSLocale currentLocale];
                NSString *country = [locale localeIdentifier];
                
                NSString *appVersion = [[NSBundle mainBundle]
                                        objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
                
                NSString *deviceSpecs =
                [NSString stringWithFormat:@"Model: %@ \n System Version: %@ \n Language: %@ \n Country: %@ \n App Version: %@",
                 model, systemVersion, language, country, appVersion];
                NSLog(@"Device Specs --> %@",deviceSpecs);
                
                //        NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter issue:\n \n My Device Specs: \n %@",deviceSpecs];
                //        NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"Email BICSI Tech Support"];
                
                NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter your comments"];
                NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"My Comments: 2014 Fall Conference"];
                
                
                // Email Subject
                NSString *emailTitle = emailNoteSubject;
                // Email Content
                NSString *messageBody = emailNoteBody;
                // To address
                NSArray *toRecipents = [NSArray arrayWithObject:@"support@bicsi.org"];
                
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:NO];
                [mc setToRecipients:toRecipents];
                
                // Present mail view controller on screen
                [self presentViewController:mc animated:YES completion:NULL];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Your device doesn't support the composer sheet"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                
            }
            [sidebar dismissAnimated:YES completion:nil];
            break;
            
        default:
            break;
        }
    }
    else { //STUFF FOR IPHONE
        NSLog(@"Tapped item at index %lu",(unsigned long)index);
        switch (index) {
            case 0:
                [self performSegueWithIdentifier:@"segueToSurveys" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
            
            case 1:
                [self performSegueWithIdentifier:@"segueToFM" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
            case 2:
                [self performSegueWithIdentifier:@"segueToPresentations" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
            
            case 3:
                [self performSegueWithIdentifier:@"segueToCECInfo" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
                
            case 4:
                [self performSegueWithIdentifier:@"segueToExams" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
            case 5:
                [self performSegueWithIdentifier:@"segueToCM" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
            case 6:
                [self performSegueWithIdentifier:@"segueToHotel" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
            
            case 7:
                [self performSegueWithIdentifier:@"segueToFAA" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
            case 8:
                [self performSegueWithIdentifier:@"segueToContactUs" sender:self];
                
                [sidebar dismissAnimated:YES completion:nil];
                break;
                
            case 9:
                if ([MFMailComposeViewController canSendMail])
                {
                    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
                    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
                    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
                    
                    NSLog(@"Untruncated Device ID is: %@", deviceID);
                    NSLog(@"Truncated Device ID is: %@", newDeviceID);
                    
                    
                    UIDevice *currentDevice = [UIDevice currentDevice];
                    NSString *model = [currentDevice model];
                    NSString *systemVersion = [currentDevice systemVersion];
                    
                    NSArray *languageArray = [NSLocale preferredLanguages];
                    NSString *language = [languageArray objectAtIndex:0];
                    NSLocale *locale = [NSLocale currentLocale];
                    NSString *country = [locale localeIdentifier];
                    
                    NSString *appVersion = [[NSBundle mainBundle]
                                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
                    
                    NSString *deviceSpecs =
                    [NSString stringWithFormat:@"Model: %@ \n System Version: %@ \n Language: %@ \n Country: %@ \n App Version: %@",
                     model, systemVersion, language, country, appVersion];
                    NSLog(@"Device Specs --> %@",deviceSpecs);
                    
                    //        NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter issue:\n \n My Device Specs: \n %@",deviceSpecs];
                    //        NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"Email BICSI Tech Support"];
                    
                    NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter your comments"];
                    NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"My Comments: 2014 Fall Conference"];
                    
                    
                    // Email Subject
                    NSString *emailTitle = emailNoteSubject;
                    // Email Content
                    NSString *messageBody = emailNoteBody;
                    // To address
                    NSArray *toRecipents = [NSArray arrayWithObject:@"support@bicsi.org"];
                    
                    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                    mc.mailComposeDelegate = self;
                    [mc setSubject:emailTitle];
                    [mc setMessageBody:messageBody isHTML:NO];
                    [mc setToRecipients:toRecipents];
                    
                    // Present mail view controller on screen
                    [self presentViewController:mc animated:YES completion:NULL];
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                    message:@"Your device doesn't support the composer sheet"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
                    
                }
                [sidebar dismissAnimated:YES completion:nil];
                break;
            default:
                break;
        }

    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"segueToHotel"]) {
        
        HotelWebViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Hotel Information";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToContactUs"]) {
        
        ContactUsViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Contact Us";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToCECInfo"]) {
        
        CECInfoViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"CEC Information";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToExams"]) {
        
        ExamsViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Training & Exams";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToPresentations"]) {
        
        ProgramPDFViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Presentations";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToFAA"]) {
        
        FindAreaActivitiesViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToFM"]) {
        
        FloorMapsViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Floor Maps";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToCM"]) {
        
        ComMeetingsMainViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Committee Meetings";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
    if ([segue.identifier isEqualToString:@"segueToSurveys"]) {
        
        SurveysViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"Surveys";
        [[segue destinationViewController] setDelegate:self];
        
    }
    
}

-(void) showTutorialOverlay
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) /* Device is iPad */
    {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    UIView *tutView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    [tutView setBackgroundColor:[UIColor blackColor]];
    [tutView setAlpha:0.4];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = topView.frame;
    [button addTarget:self action:@selector(hideTutorialOverlay) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    UIImageView *tutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay5-ipad@2x.png"]];
    [tutImageView setFrame:CGRectMake(0, (-1) * statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    [tutView addSubview:button];
    [topView addSubview:tutView];
    [topView addSubview:tutImageView];
    topView.tag = 12;
    
    [self.view addSubview:topView];
        
    }
    
    else{
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        
        UIView *tutView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        [tutView setBackgroundColor:[UIColor blackColor]];
        [tutView setAlpha:0.4];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = topView.frame;
        [button addTarget:self action:@selector(hideTutorialOverlay) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        
        UIImageView *tutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay5"]];
        [tutImageView setFrame:CGRectMake(0, (-1) * statusBarFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        
        
        [tutView addSubview:button];
        [topView addSubview:tutView];
        [topView addSubview:tutImageView];
        topView.tag = 12;
        
        [self.view addSubview:topView];
    }
    
}


-(void) hideTutorialOverlay
{
    
    UIView *topview = [self.view.window viewWithTag:12];
    [topview removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenOverlay"];
    
}




@end
