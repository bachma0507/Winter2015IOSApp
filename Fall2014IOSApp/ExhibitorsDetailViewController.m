//
//  ExhibitorsDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitorsDetailViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "ExhibitorWebViewController.h"
#import "LocateOnMapViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBook/ABPerson.h>

@interface ExhibitorsDetailViewController ()

@end

@implementation ExhibitorsDetailViewController
@synthesize myExhibitors, boothNumberLabel, nameLabel, urlLabel, myWebView, favoritesButton, exhibitorName, boothNumber, boothId, coId, eventId, activity, boothLabel, name, locationButton, url, phone, phoneLabel;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
	UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (screenSize.height < 560.0f) {
//           [self.locationButton setHidden:YES];
//        }
//    }
    
    self.title = myExhibitors.name;
    
    //set our labels
    nameLabel.text = myExhibitors.name;
    nameLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
    nameLabel.textColor = [UIColor colorWithRed:22/255.0 green:29/255.0 blue:60/255.0 alpha:1.0];
    boothNumberLabel.text = myExhibitors.boothLabel;
    phoneLabel.text = myExhibitors.phone;
    urlLabel.text = myExhibitors.url;
    //boothNumberLabel.text =;
    
    myWebView.delegate = self;
        
        //NSString *httpSource = @"http://s23.a2zinc.net/clients/BICSI/fall2013//Public/GeneratePDF.aspx?IMID=undefined&EventId=20&MapId=20";
        //NSString * myURL = [NSString stringWithFormat:@"http://www.bicsi.org/m2/Floor.aspx?BoothId=%@", myExhibitors.boothLabel];
        NSString * myURL = [NSString stringWithFormat:@"http://s23.a2zinc.net/clients/BICSI/winter2014/public/eBooth.aspx?Nav=false&BoothID=%@&EventID=%@&CoID=%@&Source=ExhibitorList", myExhibitors.boothId, myExhibitors.eventId, myExhibitors.coId];
        NSURL *fullUrl = [NSURL URLWithString:myURL];
        NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
        [myWebView loadRequest:httpRequest];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorites" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"boothnumber == %@ && favorite == 'Yes'",self.boothNumberLabel.text]];
    NSLog(@"MY BOOTH NUMBER IS: %@",self.boothNumberLabel.text);
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
    //[self.refreshControl endRefreshing];
    self.objects = results;
    NSLog(@"Results Count is: %lu", (unsigned long)results.count);
    if (!results || !results.count){
        
        [self.favoritesButton setTitle:@"Add to Favorites" forState:normal];
    }
    else{
        
        
        [self.favoritesButton setTitle:@"Remove from Favorites" forState:normal];
    }
    
    //    } onFailure:^(NSError *error) {
    //
    //        //[self.refreshControl endRefreshing];
    //        NSLog(@"An error %@, %@", error, [error userInfo]);
    //    }];

    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activity startAnimating];
    
    
}


//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [myWebView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 1.25;"];
    
    //NSLog(@"webViewDidFinishLoad is called.");
    
    [activity stopAnimating];
    activity.hidden = TRUE;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[ request URL ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
    }
    //[ requestURL release ];
    return YES;
}



- (IBAction)buttonPressed:(id)sender {
    
    //NSString * myURL = [NSString stringWithFormat:@"%@", myExhibitors.url];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
     NSString * myURL = [NSString stringWithFormat:@"http://s23.a2zinc.net/clients/BICSI/winter2014/public/eBooth.aspx?Nav=false&BoothID=%@&EventID=%@&CoID=%@&Source=ExhibitorList", myExhibitors.boothId, myExhibitors.eventId, myExhibitors.coId];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
    

}

- (IBAction)favoritesButtonPressed:(id)sender{
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    NSLog(@"MY DEVICE ID IS: %@",newDeviceID);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if ([self.favoritesButton.currentTitle isEqual:@"Add to Favorites"]) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Favorites" inManagedObjectContext:context];
        
        [newManagedObject setValue:self.boothNumberLabel.text forKey:@"boothnumber"];
        [newManagedObject setValue:self.nameLabel.text forKey:@"exhibitorname"];
        [newManagedObject setValue:self.urlLabel.text forKey:@"url"];
        [newManagedObject setValue:self.phoneLabel.text forKey:@"phone"];
        [newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
        [newManagedObject setValue:@"Yes" forKey:@"favorite"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        NSLog(@"You created a new FAVORITES object!");
        [favoritesButton setTitle:@"Remove from Favorites" forState:normal];
        
        
        /////
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];
        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameLabel.text]];
        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
        self.objects = results2;
        NSLog(@"Results Count is: %lu", (unsigned long)results2.count);
        if (!results2 || !results2.count){//start nested if block
            NSLog(@"No results2");}
        else{
            NSManagedObject *object = [results2 objectAtIndex:0];
            [object setValue:@"Yes" forKey:@"fav"];
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
        
        }
        
        
        NSLog(@"You updated a FAV to YES object in Exhibitors!");
        /////
        
        
    }
    else{//start else block
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorites" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"deviceowner == %@ && favorite == 'Yes'",newDeviceID]];
        NSLog(@"MY DEVICE ID IS: %@",newDeviceID);
        
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        
        self.objects = results;
        NSLog(@"Results Count is: %lu", (unsigned long)results.count);
        if (!results || !results.count){//start nested if block
            [self.favoritesButton setTitle:@"Add to Favorites" forState:normal];}
        else{
            NSManagedObject *object = [results objectAtIndex:0];
            [object setValue:NULL forKey:@"favorite"];
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
            
            NSLog(@"You updated a FAVORITES object");
            [self.favoritesButton setTitle:@"Add to Favorites" forState:normal];
        }
        //////
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];

        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameLabel.text]];
        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
        
        self.objects = results2;
        NSLog(@"Results Count is: %lu", (unsigned long)results2.count);
        if (!results2 || !results2.count){//start nested if block
            NSLog(@"No results2");}
        else{
            NSManagedObject *object = [results2 objectAtIndex:0];
            [object setValue:NULL forKey:@"fav"];
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
            
            NSLog(@"You updated a FAV to NULL object in Exhibitors");
            
        }

        
        
        //////
    }//end nested if block
    
}//end else block

- (IBAction)mapButtonPressed:(id)sender {
    
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notesDetail"]) {
        self.exhibitorName = nameLabel.text;
        self.boothNumber = boothNumberLabel.text;
        
        ExhibitorNotesViewController *destViewController = segue.destinationViewController;
        destViewController.title = nameLabel.text;
        destViewController.exhibitorName = self.exhibitorName;
        destViewController.boothNumber = self.boothNumber;
        
        NSLog(@"Booth Number is %@", self.boothNumber);
    }
    
    else if ([segue.identifier isEqualToString:@"webDetail"]) {
            self.coId = myExhibitors.coId;
            self.boothId = myExhibitors.boothId;
            self.eventId = myExhibitors.eventId;
            
            ExhibitorWebViewController *destViewController = segue.destinationViewController;
            destViewController.title = nameLabel.text;
            destViewController.coId = self.coId;
            destViewController.boothId = self.boothId;
            destViewController.eventId = self.eventId;
            
            NSLog(@"Booth ID is %@", self.boothId);
    }
    
    else if ([segue.identifier isEqualToString:@"locationDetail"]) {
        self.boothLabel = myExhibitors.boothLabel;
        self.name = myExhibitors.name;
        
        LocateOnMapViewController *destViewController = segue.destinationViewController;
        //destViewController.title = nameLabel.text;
        destViewController.boothLabel = self.boothLabel;
        destViewController.title = self.name;
        
        NSLog(@"Booth Label is %@", self.boothLabel);
    }


}

//-(void)saveAsContact{
//    ABAddressBookRef addressBook = ABAddressBookCreate();
//    ABRecordRef person = ABPersonCreate();
//    
//    ABRecordSetValue(person, kABPersonFirstNameProperty, @"Kate" , nil);
//    ABRecordSetValue(person, kABPersonLastNameProperty, @"Hutson", nil);
//    ABAddressBookAddRecord(addressBook, person, nil);
//    ABAddressBookSave(addressBook, nil);
//    
//    
//    
//}



@end
