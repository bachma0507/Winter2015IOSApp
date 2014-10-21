//
//  Fall2013IOSAppAppDelegate.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Fall2013IOSAppAppDelegate.h"
#import "Reachability.h"
#import "RNCachingURLProtocol.h"
#import "Fall2013IOSAppViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FBsession.h>
#import "MBProgressHUD.h"
#import "StartPageViewController.h"
#import <AdSupport/AdSupport.h>
#import "TestFlight.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
//#import <FYX/FYX.h>


@implementation Fall2013IOSAppAppDelegate

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize window;
@synthesize json, exhibitorsArray, speakersArray, sessionsArray, sponsorsArray, cscheduleArray, exhibitHallArray, htmlArray;


NSMutableArray *clName;
int iNotificationCounter=0;

- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    [splashView removeFromSuperview];
    
}


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    self.customLocationManager = [[CLLocationManager alloc] init];
    self.customLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.customLocationManager.delegate = self;
    [self.customLocationManager startUpdatingLocation];
    
//    [FYX setAppId:@"d17301d893728e50c4540b408387df0989ddf83147ad8f3617c61f8a281944d1" appSecret:@"7bb2bf821f6f71a9c37117fa7cab66e02ac353fa83c80163184aa33dc3d7ece0" callbackUrl:@"orgbicsicanada2014app://authcode"];
//    
//    [FYX startService:self];
//    
//    self.visitManager = [FYXVisitManager new];
//    self.visitManager.delegate = self;
//    [self.visitManager start];
    
    // Setup TestFlight
    
    [TestFlight takeOff:@"216554ba-aef6-4ec1-a079-fb5751c82be6"];
    
    // Use this option to notifiy beta users of any updates
    [TestFlight setOptions:@{ TFOptionDisableInAppUpdates : @YES }];
    
    [Parse setApplicationId:@"H025T6dVCXIyDm0kVYZEyMjqap5K36iu0ZsgYVai"
                  clientKey:@"7uI3KCMsxUBxkivTAg8WYXI82wJPqFzA3EvOKH72"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
   
    [Crittercism enableWithAppID:@"543ec860466eda53e4000028"];
    
    [PFFacebookUtils initializeFacebook];
    
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    clName = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    // Override point for customization after application launch.
    // Initial setup
    //[[PushIOManager sharedInstance] setDelegate:self];
    //[[PushIOManager sharedInstance] didFinishLaunchingWithOptions:launchOptions];
    
//    // Requests a device token from Apple
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert     | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    
   //[[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        UIImage *navBackgroundImage = [UIImage imageNamed:@"navbarflatblue"];
        [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbarflatblack2"];
//    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x3[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        
            }
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
//    // Change the appearance of back button
    UIImage *backButtonImage = [[UIImage imageNamed:@"backbutton.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];

        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
//    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabBarBackground"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor /*whiteColor*/colorWithRed:255/255.0 green:214/255.0 blue:203/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], UITextAttributeTextColor,
                                                    
                                                           //[UIColor colorWithRed:193/255.0 green:70/255.0 blue:162/255.0 alpha:1.0], UITextAttributeTextColor,
                                                           [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],UITextAttributeTextShadowColor,
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,
                                                           //[UIFont fontWithName:@"HelveticaNeue-CondensedBlack"
                                                           [UIFont fontWithName:@"Arial"size:20.0], UITextAttributeFont, nil]];

    
    
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
//        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//        UITabBar *tabBar = tabBarController.tabBar;
//        UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//        UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//        UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//        UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
//        UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
//        
//        
//        
//        tabBarItem1.title = @"Home";
//        tabBarItem2.title = @"Alerts";
//        tabBarItem3.title = @"Social";
//        tabBarItem4.title = @"My BICSI";
//        tabBarItem5.title = @"Gallery";
//        
//        
//        
//        [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"home_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home_tab_icon_unselected.png"]];
//        [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"news_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"news_tab_icon_unselected.png"]];
//        [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"social_tab_icon_selected.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"social_tab_icon_unselected.png"]];
//        [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"mybicsi_tab_icon_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"mybicsi_tab_icon_unselected.png"]];
//        [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"gallery_tab_icon_selected.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"gallery_tab_icon_unselected.png"]];
//        
//
//    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // code here
        
        // Assign tab bar item with titles
            UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
            UITabBar *tabBar = tabBarController.tabBar;
            //[tabBarController.tabBar setBackgroundColor:[UIColor blackColor]];
            //tabBarController.tabBar.translucent = NO;
            UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
            UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
            UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
            UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
            UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
        
        //
        //
            tabBarItem1.selectedImage = [[UIImage imageNamed:@"home_tab_icon_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem1.image = [[UIImage imageNamed:@"home_tab_icon_unselected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem1.title = @"Home";
        
            tabBarItem2.selectedImage = [[UIImage imageNamed:@"news_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem2.image = [[UIImage imageNamed:@"news_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem2.title = @"News & Alerts";
        
            tabBarItem3.selectedImage = [[UIImage imageNamed:@"social_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem3.image = [[UIImage imageNamed:@"social_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem3.title = @"Chat Rooms";
        
            tabBarItem4.selectedImage = [[UIImage imageNamed:@"mybicsi_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem4.image = [[UIImage imageNamed:@"mybicsi_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem4.title = @"My BICSI";
        
            tabBarItem5.selectedImage = [[UIImage imageNamed:@"gallery_tab_icon_selected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem5.image = [[UIImage imageNamed:@"gallery_tab_icon_unselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
            tabBarItem5.title = @"Photo Gallery";
        
            

        
    }
    
    
    
  
    
    
    //maaj code 062313
  //  /*NSTimer *time =*/ [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshTable) userInfo:nil repeats:NO];

    //[window addSubview:viewController.view];
//    [window makeKeyAndVisible];
//    
//    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,window.frame.size.width,window.frame.size.height)];
//    splashView.image = [UIImage imageNamed:@"LaunchImage"];
//    [window addSubview:splashView];
//    [window bringSubviewToFront:splashView];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
//    splashView.alpha = 0.0;
//    [UIView commitAnimations];
    
    
    
    
    [self updateAllData];
    
    
    return YES;
    
    
}



-(void)updateAllData{
    
#pragma mark - Check to see if Internet Connection Available
    //CHECK TO SEE IF INTERNET CONNECTION IS AVAILABLE
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    //If internet connection not available then do not delete objects
    if (netStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No internet connection. Data cannot be updated until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{//START REACHABILITY ELSE
        //FETCH AND DELETE EXHIBITOR OBJECTS
        
#pragma mark - Fetch and Delete Exhibitor Objects
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        self.objects = myResults;
        if (!myResults || !myResults.count){
            NSLog(@"No Exhibitor objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResults) {
                if (![[managedObject valueForKey:@"fav"] isEqualToString:@"Yes"]) {
                    
                    
                    [context deleteObject:managedObject];
                    
                    
                    NSError *error = nil;
                    // Save the object to persistent store
                    if (![context save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    }
                    NSLog(@"Exhibitor object deleted!");
                    
                }
            }
        }
        //FETCH AND DELETE SPEAKER OBJECTS
        #pragma mark - Fetch and Delete Speaker Objects
        NSManagedObjectContext *contextSpeakers = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestSpeakers = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entitySpeakers = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:contextSpeakers];
        
        [fetchRequestSpeakers setEntity:entitySpeakers];
        
        NSArray *myResultsSpeakers = [self.managedObjectContext executeFetchRequest:fetchRequestSpeakers error:nil];
        self.objects = myResultsSpeakers;
        if (!myResultsSpeakers || !myResultsSpeakers.count){
            NSLog(@"No Speaker objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsSpeakers) {
                [contextSpeakers deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextSpeakers save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Speaker object deleted!");
                
            }
        }
        
        
        //---------------------------------
        
        //FETCH AND DELETE SESSION OBJECTS
        #pragma mark - Fetch and Delete Session Objects
        NSManagedObjectContext *contextSessions = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestSessions = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entitySessions = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:contextSessions];
        
        [fetchRequestSessions setEntity:entitySessions];
        
        NSArray *myResultsSessions = [self.managedObjectContext executeFetchRequest:fetchRequestSessions error:nil];
        self.objects = myResultsSessions;
        if (!myResultsSessions || !myResultsSessions.count){
            NSLog(@"No Session objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsSessions) {
                if (![[managedObject valueForKey:@"planner"] isEqualToString:@"Yes"]) {
                
                
                [contextSessions deleteObject:managedObject];
                
                    
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextSessions save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Session object deleted!");
                
            }
        }
    }
        
        //---------------------------------
        
        
        //---------------------------------
        
        //FETCH AND DELETE SPONSOR OBJECTS
        #pragma mark - Fetch and Delete Sponsor Objects
        NSManagedObjectContext *contextSponsors = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestSponsors = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entitySponsors = [NSEntityDescription entityForName:@"Sponsors" inManagedObjectContext:contextSponsors];
        
        [fetchRequestSponsors setEntity:entitySponsors];
        
        NSArray *myResultsSponsors = [self.managedObjectContext executeFetchRequest:fetchRequestSponsors error:nil];
        self.objects = myResultsSponsors;
        if (!myResultsSponsors || !myResultsSponsors.count){
            NSLog(@"No Sponsor objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsSponsors) {
                [contextSponsors deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextSponsors save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Sponsor object deleted!");
                
            }
        }
        
        
        //---------------------------------
        
        
        //---------------------------------
        
        //FETCH AND DELETE CSCHEDULE OBJECTS
        #pragma mark - Fetch and Delete CSchedule Objects
        NSManagedObjectContext *contextCschedule = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestCschedule = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityCschedule = [NSEntityDescription entityForName:@"Cschedule" inManagedObjectContext:contextCschedule];
        
        [fetchRequestCschedule setEntity:entityCschedule];
        
        NSArray *myResultsCschedule = [self.managedObjectContext executeFetchRequest:fetchRequestCschedule error:nil];
        self.objects = myResultsCschedule;
        if (!myResultsCschedule || !myResultsCschedule.count){
            NSLog(@"No CSchedule objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsCschedule) {
                [contextCschedule deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextCschedule save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"CSchedule object deleted!");
                
            }
        }
        
        
        
        //---------------------------------
        
        //FETCH AND DELETE EHSCHEDULE OBJECTS
        #pragma mark - Fetch and Delete EHSchedule Objects
        NSManagedObjectContext *contextEhschedule = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestEhschedule = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityEhschedule = [NSEntityDescription entityForName:@"Ehschedule" inManagedObjectContext:contextEhschedule];
        
        [fetchRequestEhschedule setEntity:entityEhschedule];
        
        NSArray *myResultsEhschedule = [self.managedObjectContext executeFetchRequest:fetchRequestEhschedule error:nil];
        self.objects = myResultsEhschedule;
        if (!myResultsEhschedule || !myResultsEhschedule.count){
            NSLog(@"No EHSchedule objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsEhschedule) {
                [contextEhschedule deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextEhschedule save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"EHSchedule object deleted!");
                
            }
        }

        //---------------------------------
        
        //FETCH AND DELETE HTML OBJECTS
        NSManagedObjectContext *contextHtml = [self managedObjectContext];
        
        NSFetchRequest *fetchRequestHtml = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityHtml = [NSEntityDescription entityForName:@"Html" inManagedObjectContext:contextHtml];
        
        [fetchRequestHtml setEntity:entityHtml];
        
        NSArray *myResultsHtml = [self.managedObjectContext executeFetchRequest:fetchRequestHtml error:nil];
        self.objects = myResultsHtml;
        if (!myResultsHtml || !myResultsHtml.count){
            NSLog(@"No Html objects found to be deleted!");
        }
        else{
            for (NSManagedObject *managedObject in myResultsHtml) {
                [contextHtml deleteObject:managedObject];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![contextHtml save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                NSLog(@"Html object deleted!");
                
            }
        }
        
        //---------------------------------
        
        
        //CREATE EXHIBITOR OBJECTS
        #pragma mark - Create Exhibitor Objects
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/exhibitorsF14.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //Set up our exhibitors array
                exhibitorsArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create exhibitors object
                    NSString * blabel = [[json objectAtIndex:i] objectForKey:@"BoothLabel"];
                    NSString * bName = [[json objectAtIndex:i] objectForKey:@"Name"];
                    NSString * bURL = [[json objectAtIndex:i] objectForKey:@"HyperLnkFldVal"];
                    NSString * bboothId = [[json objectAtIndex:i] objectForKey:@"BoothID"];
                    NSString * bmapId = [[json objectAtIndex:i] objectForKey:@"MapID"];
                    NSString * bcoId = [[json objectAtIndex:i] objectForKey:@"CoID"];
                    NSString * beventId = [[json objectAtIndex:i] objectForKey:@"EventID"];
                    NSString * bphone = [[json objectAtIndex:i] objectForKey:@"Phone"];
                    
                    
                    exhibitors * myExhibitors = [[exhibitors alloc] initWithBoothName: bName andboothLabel: blabel andBoothURL: bURL andMapId: bmapId andCoId:bcoId andEventId: beventId andBoothId: bboothId andPhone: bphone];
                    
                    
                    //Add our exhibitors object to our exhibitorsArray
                    [exhibitorsArray addObject:myExhibitors];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@ && boothLabel == %@",myExhibitors.name, myExhibitors.boothLabel]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    
                    NSLog(@"EXHIBITOR MYRESULTS COUNT = %lu", myResults.count);
                    
                    if (myResults.count >= 1) {
                        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
                        
                        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:context];
                        [fetchRequest2 setEntity:entity2];
                        
                        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"name == %@ && coId == %@",myExhibitors.name, myExhibitors.coId]];
                        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
                        
                        self.objects = results2;
                        
                        NSManagedObject *object = [results2 objectAtIndex:0];
						
						[object setValue:myExhibitors.name forKey:@"name"];
                        
                        [object setValue:myExhibitors.boothLabel forKey:@"boothLabel"];
                        NSString * myCoId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.coId];
                        [object setValue:myCoId forKey:@"coId"];
                        NSString * myMapId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.mapId];
                        [object setValue:myMapId forKey:@"mapId"];
                        NSString * myBoothId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.boothId];
                        [object setValue:myBoothId forKey:@"boothId"];
                        NSString * myEventId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.eventId];
                        [object setValue:myEventId forKey:@"eventId"];
                        NSString * myPhone = [[NSString alloc] initWithFormat:@"%@",myExhibitors.phone];
                        [object setValue:myPhone forKey:@"phone"];
                        NSString * myURL = [[NSString alloc] initWithFormat:@"%@",myExhibitors.url];
                        [object setValue:myURL forKey:@"url"];
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                            
                        }
                        NSLog(@"You updated an object in Exhibitors");
                    }
                    
                    
                    
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Exhibitors" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:myExhibitors.name forKey:@"name"];
                        
                        [newManagedObject setValue:myExhibitors.boothLabel forKey:@"boothLabel"];
                        NSString * myCoId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.coId];
                        [newManagedObject setValue:myCoId forKey:@"coId"];
                        NSString * myMapId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.mapId];
                        [newManagedObject setValue:myMapId forKey:@"mapId"];
                        NSString * myBoothId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.boothId];
                        [newManagedObject setValue:myBoothId forKey:@"boothId"];
                        NSString * myEventId = [[NSString alloc] initWithFormat:@"%@",myExhibitors.eventId];
                        [newManagedObject setValue:myEventId forKey:@"eventId"];
                        NSString * myPhone = [[NSString alloc] initWithFormat:@"%@",myExhibitors.phone];
                        [newManagedObject setValue:myPhone forKey:@"phone"];
                        NSString * myURL = [[NSString alloc] initWithFormat:@"%@",myExhibitors.url];
                        [newManagedObject setValue:myURL forKey:@"url"];
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Exhibitor object!");
                    }
                    
                    
                }
                
                
                
            });
        });
        
        
        //CREATE SPEAKER1 OBJECTS
        #pragma mark - Create Speaker1 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    //NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer1org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer1firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer1lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer1city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer1state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer1country"];
                    //NSString * sBio = [[json objectAtIndex:i] objectForKey:@"speakerbio"];
                    //NSString * sWebsite = [[json objectAtIndex:i] objectForKey:@"website"];
                    //NSString * sPic = [[json objectAtIndex:i] objectForKey:@"speakerPic"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    //NSString * sSession1Time = [[json objectAtIndex:i] objectForKey:@"session1Time"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    //NSString * sSession2 = [[json objectAtIndex:i] objectForKey:@"session2"];
//                    NSString * sSession2Date = [[json objectAtIndex:i] objectForKey:@"session2Date"];
//                    NSString * sSession2Time = [[json objectAtIndex:i] objectForKey:@"session2Time"];
//                    NSString * sSession2Desc = [[json objectAtIndex:i] objectForKey:@"session2Desc"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    //NSString * sSessionID2 = [[json objectAtIndex:i] objectForKey:@"sessionID2"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
//                    NSString * sSess2StartTime = [[json objectAtIndex:i] objectForKey:@"sess2StartTime"];
//                    NSString * sSess2EndTime = [[json objectAtIndex:i] objectForKey:@"sess2EndTime"];
//                    NSString * sLocation2 = [[json objectAtIndex:i] objectForKey:@"location2"];
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        //[newManagedObject setValue:mySpeakers.speakerID forKey:@"speakerID"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        //[newManagedObject setValue:mySpeakers.speakerBio forKey:@"speakerBio"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        //[newManagedObject setValue:mySpeakers.session1Time forKey:@"session1Time"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
//                        [newManagedObject setValue:mySpeakers.session2 forKey:@"session2"];
//                        [newManagedObject setValue:mySpeakers.session2Date forKey:@"session2Date"];
//                        [newManagedObject setValue:mySpeakers.session2Time forKey:@"session2Time"];
//                        [newManagedObject setValue:mySpeakers.session2Desc forKey:@"session2Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
//                        [newManagedObject setValue:mySpeakers.speakerWebsite forKey:@"speakerWebsite"];
//                        [newManagedObject setValue:mySpeakers.speakerPic forKey:@"speakerPic"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
//                        NSString * mySess2StartTime = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sess2StartTime];
//                        [newManagedObject setValue:mySess2StartTime forKey:@"sess2StartTime"];
//                        NSString * mySess2EndTime = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sess2EndTime];
//                        [newManagedObject setValue:mySess2EndTime forKey:@"sess2EndTime"];
//                        NSString * myLocation2 = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location2];
//                        [newManagedObject setValue:myLocation2 forKey:@"location2"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
//                        NSString * mySessionID2 = [[NSString alloc] initWithFormat:@"%@",mySpeakers.sessionID2];
//                        [newManagedObject setValue:mySessionID2 forKey:@"sessionID2"];
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
            
        });
        
        
        
        
        //-------------------------
        
        //CREATE SPEAKER2 OBJECTS
        #pragma mark - Create Speaker2 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer2org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer2firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer2lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer2city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer2state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer2country"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
                
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//                
//            }

        });
        
        
        
        
        //-------------------------
        
        //CREATE SPEAKER3 OBJECTS
        #pragma mark - Create Speaker3 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer3org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer3firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer3lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer3city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer3state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer3country"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
                
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//                
//            }

        });
        
        
        
        
        //-------------------------
        
        //CREATE SPEAKER4 OBJECTS
        #pragma mark - Create Speaker4 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer4org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer4firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer4lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer4city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer4state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer4country"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
                
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//                
//            }

        });
        
        
        
        
        //-------------------------
        
        //CREATE SPEAKER5 OBJECTS
        #pragma mark - Create Speaker5 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer5org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer5firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer5lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer5city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer5state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer5country"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
                
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//                
//            }

        });
        
        
        
        
        //-------------------------
        
        //CREATE SPEAKER6 OBJECTS
        #pragma mark - Create Speaker6 Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE

            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                //Set up our speakers array
                speakersArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create speakers object
                    
                    NSString * sCompany = [[json objectAtIndex:i] objectForKey:@"trainer6org"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"trainer6firstname"];
                    NSString * sLastname = [[json objectAtIndex:i] objectForKey:@"trainer6lastname"];
                    NSString * sCity = [[json objectAtIndex:i] objectForKey:@"trainer6city"];
                    NSString * sState = [[json objectAtIndex:i] objectForKey:@"trainer6state"];
                    NSString * sCountry = [[json objectAtIndex:i] objectForKey:@"trainer6country"];
                    NSString * sSession1 = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sSession1Date = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSession1Desc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    
                    
                    
                    Speakers * mySpeakers = [[Speakers alloc] initWithSpeakerName: sName andSpeakerLastName: sLastname andSpeakerCompany: sCompany andSpeakerCity: sCity andSpeakerState: sState andSpeakerCountry: sCountry andSession1: sSession1 andSession1Date: sSession1Date andSession1Desc: sSession1Desc andSessionID:sSessionID andStartTime: sStartTime andEndTime: sEndTime andLocation: sLocation];
                    
                    
                    //Add our speakers object to our speakersArray
                    [speakersArray addObject:mySpeakers];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"speakerLastName == %@",mySpeakers.speakerLastName]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Speakers" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySpeakers.speakerName forKey:@"speakerName"];
                        [newManagedObject setValue:mySpeakers.speakerLastName forKey:@"speakerLastName"];
                        [newManagedObject setValue:mySpeakers.speakerCompany forKey:@"speakerCompany"];
                        [newManagedObject setValue:mySpeakers.speakerCity forKey:@"speakerCity"];
                        [newManagedObject setValue:mySpeakers.speakerState forKey:@"speakerState"];
                        [newManagedObject setValue:mySpeakers.speakerCountry forKey:@"speakerCountry"];
                        [newManagedObject setValue:mySpeakers.session1 forKey:@"session1"];
                        [newManagedObject setValue:mySpeakers.session1Date forKey:@"session1Date"];
                        [newManagedObject setValue:mySpeakers.session1Desc forKey:@"session1Desc"];
                        [newManagedObject setValue:mySpeakers.startTime forKey:@"startTime"];
                        [newManagedObject setValue:mySpeakers.endTime forKey:@"endTime"];
                        NSString * myLocation = [[NSString alloc] initWithFormat:@"%@",mySpeakers.location];
                        [newManagedObject setValue:myLocation forKey:@"location"];
                        [newManagedObject setValue:mySpeakers.sessionID forKey:@"sessionID"];
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Speaker object!");
                    }
                    
                    
                    
                }
                
            });
                
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//                
//            }

        });
        
        
        
        
        //-------------------------

        
        //CREATE SESSION OBJECTS
        #pragma mark - Create Session Objects
        
        //@try {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            //NSHTTPURLResponse *response = nil;
            
            //NSURL *url = [NSURL URLWithString:@"http://www.speedyreference.com/bicsi/convertcsv1.json"];
            NSURL *url = [NSURL URLWithString:@"https://webservice.bicsi.org/json/reply/MobSession?SessionAltCd=CN-WINTER-FL-0215"];
            //NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/bicsi/testtrunc3.json"];
            
            //if ([response statusCode] >= 200 && [response statusCode] < 300){//BEGIN IF RESPONSE STATUSCODE
                
            
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            
            //TRUNCATE FRONT AND END OF JSON. ALSO JSON STATEMENT AND CHANGE SESSIONDATE DATE FORMAT
            NSString * dataStr = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
            NSString *newDataStr = [dataStr substringWithRange:NSMakeRange(13, [dataStr length]-13)];
            NSString *truncDataStr = [newDataStr substringToIndex:[ newDataStr length]-1 ];
            
            
//            NSLog(@"After truncated from front: %@", newDataStr);
//            NSLog(@"After truncated from end: %@", truncDataStr);
            
            NSData* truncData = [truncDataStr dataUsingEncoding:NSUTF8StringEncoding];
            ///////////////
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //USE STATEMENT BELOW FOR JSON TRUNCATE
                json = [NSJSONSerialization JSONObjectWithData:truncData options:kNilOptions error:nil];
                
                
                //Set up our sessions array
                sessionsArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create sessions object
                    
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"functiontitle"];
                    NSString * sDate = [[json objectAtIndex:i] objectForKey:@"fucntioindate"];
                    NSString * sSpeaker1 = [[json objectAtIndex:i] objectForKey:@"trainer1firstname"];
                    NSString * sSpeaker1Company = [[json objectAtIndex:i] objectForKey:@"trainer1org"];
                    NSString * sSpeaker2 = [[json objectAtIndex:i] objectForKey:@"trainer2firstname"];
                    NSString * sSpeaker2Company = [[json objectAtIndex:i] objectForKey:@"trainer2org"];
                    NSString * sSpeaker3 = [[json objectAtIndex:i] objectForKey:@"trainer3firstname"];
                    NSString * sSpeaker3Company = [[json objectAtIndex:i] objectForKey:@"trainer3org"];
                    NSString * sSpeaker4 = [[json objectAtIndex:i] objectForKey:@"trainer4firstname"];
                    NSString * sSpeaker4Company = [[json objectAtIndex:i] objectForKey:@"trainer4org"];
                    NSString * sSpeaker5 = [[json objectAtIndex:i] objectForKey:@"trainer5firstname"];
                    NSString * sSpeaker5Company = [[json objectAtIndex:i] objectForKey:@"trainer5org"];
                    NSString * sSpeaker6 = [[json objectAtIndex:i] objectForKey:@"trainer6firstname"];
                    NSString * sSpeaker6Company = [[json objectAtIndex:i] objectForKey:@"trainer6org"];
                    NSString * sDesc = [[json objectAtIndex:i] objectForKey:@"functiondescription"];
                    NSString * sSessionID = [[json objectAtIndex:i] objectForKey:@"FUNCTIONCD"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"functionStartTime"];
                    NSString * sEndTime = [[json objectAtIndex:i] objectForKey:@"functionEndTime"];
                    NSString * sLocation = [[json objectAtIndex:i] objectForKey:@"LOCATIONNAME"];
                    NSString * sSpeaker1lastname = [[json objectAtIndex:i] objectForKey:@"trainer1lastname"];
                    NSString * sSpeaker2lastname = [[json objectAtIndex:i] objectForKey:@"trainer2lastname"];
                    NSString * sSpeaker3lastname = [[json objectAtIndex:i] objectForKey:@"trainer3lastname"];
                    NSString * sSpeaker4lastname = [[json objectAtIndex:i] objectForKey:@"trainer4lastname"];
                    NSString * sSpeaker5lastname = [[json objectAtIndex:i] objectForKey:@"trainer5lastname"];
                    NSString * sSpeaker6lastname = [[json objectAtIndex:i] objectForKey:@"trainer6lastname"];
                    
                    
                    
                    Sessions * mySessions = [[Sessions alloc] initWithSessionDate:sDate andSessionName:sName andSessionSpeaker1:sSpeaker1 andSpeaker1Company:sSpeaker1Company andSessionSpeaker2:sSpeaker2 andSpeaker2Company:sSpeaker2Company andSessionSpeaker3:sSpeaker3 andSpeaker3Company:sSpeaker3Company andSessionSpeaker4:sSpeaker4 andSpeaker4Company:sSpeaker4Company andSessionSpeaker5:sSpeaker5 andSpeaker5Company:sSpeaker5Company andSessionSpeaker6:sSpeaker6 andSpeaker6Company:sSpeaker6Company andSessionDesc:sDesc andSessionID:sSessionID andStartTime:sStartTime andEndTime:sEndTime andLocation:sLocation andSessionSpeaker1lastname:sSpeaker1lastname andSessionSpeaker2lastname:sSpeaker2lastname andSessionSpeaker3lastname:sSpeaker3lastname andSessionSpeaker4lastname:sSpeaker4lastname andSessionSpeaker5lastname:sSpeaker5lastname andSessionSpeaker6lastname:sSpeaker6lastname];
                    
                    //Add our sessions object to our sessionsArray
                    [sessionsArray addObject:mySessions];
                    NSLog(@"Sessions array count: %lu", (unsigned long)sessionsArray.count);
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@",mySessions.sessionID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    
                    NSLog(@"SESSION MYRESULTS COUNT = %lu", myResults.count);
                    
                    if (myResults.count >= 1) {
                        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
                        
                        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context];
                        [fetchRequest2 setEntity:entity2];
                        
                        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@", mySessions.sessionID]];
                        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
                        
                        self.objects = results2;
                        
                        NSManagedObject *object = [results2 objectAtIndex:0];
                        
                        NSDateFormatter *dft = [[NSDateFormatter alloc] init];
                        
                        //USE STATEMENT BELOW WHEN USING JSON TRUNCATE
                        [dft setDateFormat:@"MM-dd-yyyy"];
                        
                        //[dft setDateFormat:@"MM/dd/yyyy hh:mm"];
                        NSDate *stDate = [dft dateFromString: mySessions.sessionDate];
                        [object setValue:stDate forKey:@"sessionDate"];
                        [object setValue:mySessions.sessionSpeaker1 forKey:@"sessionSpeaker1"];
                        [object setValue:mySessions.sessionSpeaker2 forKey:@"sessionSpeaker2"];
                        [object setValue:mySessions.sessionSpeaker3 forKey:@"sessionSpeaker3"];
                        [object setValue:mySessions.sessionSpeaker4 forKey:@"sessionSpeaker4"];
                        [object setValue:mySessions.sessionSpeaker5 forKey:@"sessionSpeaker5"];
                        [object setValue:mySessions.sessionSpeaker6 forKey:@"sessionSpeaker6"];
                        [object setValue:mySessions.speaker1Company forKey:@"speaker1Company"];
                        [object setValue:mySessions.speaker2Company forKey:@"speaker2Company"];
                        [object setValue:mySessions.speaker3Company forKey:@"speaker3Company"];
                        [object setValue:mySessions.speaker4Company forKey:@"speaker4Company"];
                        [object setValue:mySessions.speaker5Company forKey:@"speaker5Company"];
                        [object setValue:mySessions.speaker6Company forKey:@"speaker6Company"];
                        [object setValue:mySessions.sessionSpeaker1lastname forKey:@"sessionSpeaker1lastname"];
                        [object setValue:mySessions.sessionSpeaker2lastname forKey:@"sessionSpeaker2lastname"];
                        [object setValue:mySessions.sessionSpeaker3lastname forKey:@"sessionSpeaker3lastname"];
                        [object setValue:mySessions.sessionSpeaker4lastname forKey:@"sessionSpeaker4lastname"];
                        [object setValue:mySessions.sessionSpeaker5lastname forKey:@"sessionSpeaker5lastname"];
                        [object setValue:mySessions.sessionSpeaker6lastname forKey:@"sessionSpeaker6lastname"];
                        [object setValue:mySessions.sessionDesc forKey:@"sessionDesc"];
                        [object setValue:mySessions.sessionID forKey:@"sessionID"];
                        
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"hh:mm a"];
                        NSDate *startTime = [df dateFromString: mySessions.startTime];
                        [object setValue:startTime forKey:@"startTime"];
                        
                        NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
                        [df2 setDateFormat:@"hh:mm a"];
                        NSDate *endTime = [df dateFromString: mySessions.endTime];
                        [object setValue:endTime forKey:@"endTime"];
                        
                        NSString * myLocation3 = [[NSString alloc] initWithFormat:@"%@",mySessions.location];
                        [object setValue:myLocation3 forKey:@"location"];
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                            
                        }
                        NSLog(@"You updated an object in Sessions");
                    }
                    
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessions" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySessions.sessionName forKey:@"sessionName"];
                        //[newManagedObject setValue:mySessions.sessionDay forKey:@"sessionDay"];
                        //[newManagedObject setValue:mySessions.sessionDate forKey:@"sessionDate"];
                        NSDateFormatter *dft = [[NSDateFormatter alloc] init];
                        
                        //USE STATEMENT BELOW WHEN USING JSON TRUNCATE
                        //[dft setDateFormat:@"MM-dd-yyyy"];
                        
                        //[dft setDateFormat:@"MM/dd/yyyy hh:mm"];
                        [dft setDateFormat:@"MM-dd-yyyy"];
                        NSDate *stDate = [dft dateFromString: mySessions.sessionDate];
                        [newManagedObject setValue:stDate forKey:@"sessionDate"];
                        
//                        NSDateFormatter *dfy = [[NSDateFormatter alloc] init];
//                        [dfy setDateFormat:@"MMM d yyyy"];
//                        NSDate *sessDate = [dfy dateFromString: mySessions.sessionDate];
//                        [newManagedObject setValue:sessDate forKey:@"sessionDate"];
                        
                        
                        [newManagedObject setValue:mySessions.sessionSpeaker1 forKey:@"sessionSpeaker1"];
                        [newManagedObject setValue:mySessions.sessionSpeaker2 forKey:@"sessionSpeaker2"];
                        [newManagedObject setValue:mySessions.sessionSpeaker3 forKey:@"sessionSpeaker3"];
                        [newManagedObject setValue:mySessions.sessionSpeaker4 forKey:@"sessionSpeaker4"];
                        [newManagedObject setValue:mySessions.sessionSpeaker5 forKey:@"sessionSpeaker5"];
                        [newManagedObject setValue:mySessions.sessionSpeaker6 forKey:@"sessionSpeaker6"];
                        [newManagedObject setValue:mySessions.speaker1Company forKey:@"speaker1Company"];
                        [newManagedObject setValue:mySessions.speaker2Company forKey:@"speaker2Company"];
                        [newManagedObject setValue:mySessions.speaker3Company forKey:@"speaker3Company"];
                        [newManagedObject setValue:mySessions.speaker4Company forKey:@"speaker4Company"];
                        [newManagedObject setValue:mySessions.speaker5Company forKey:@"speaker5Company"];
                        [newManagedObject setValue:mySessions.speaker6Company forKey:@"speaker6Company"];
                        [newManagedObject setValue:mySessions.sessionSpeaker1lastname forKey:@"sessionSpeaker1lastname"];
                        [newManagedObject setValue:mySessions.sessionSpeaker2lastname forKey:@"sessionSpeaker2lastname"];
                        [newManagedObject setValue:mySessions.sessionSpeaker3lastname forKey:@"sessionSpeaker3lastname"];
                        [newManagedObject setValue:mySessions.sessionSpeaker4lastname forKey:@"sessionSpeaker4lastname"];
                        [newManagedObject setValue:mySessions.sessionSpeaker5lastname forKey:@"sessionSpeaker5lastname"];
                        [newManagedObject setValue:mySessions.sessionSpeaker6lastname forKey:@"sessionSpeaker6lastname"];

                        
                        [newManagedObject setValue:mySessions.sessionDesc forKey:@"sessionDesc"];
                        [newManagedObject setValue:mySessions.sessionID forKey:@"sessionID"];
                        //[newManagedObject setValue:mySessions.startTime forKey:@"startTime"];
                        
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"hh:mm a"];
                        NSDate *startTime = [df dateFromString: mySessions.startTime];
                        [newManagedObject setValue:startTime forKey:@"startTime"];
                        
                        NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
                        [df2 setDateFormat:@"hh:mm a"];
                        NSDate *endTime = [df dateFromString: mySessions.endTime];
                        [newManagedObject setValue:endTime forKey:@"endTime"];
                        
                        NSString * myLocation3 = [[NSString alloc] initWithFormat:@"%@",mySessions.location];
                        [newManagedObject setValue:myLocation3 forKey:@"location"];
                        
                        
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Session object! Session ID: %@",mySessions.sessionID);
                        //NSLog(@"Object created sessionName is: %@",mySessions.sessionName);
                    }
                    
                    
                
                
                }
                
                
            });
//            }//END OF IF RESPONSE STATUSCODE
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                    message:@"Connection to database failed."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil, nil];
//                //alertView.tag = 1;
//                [alertView show];
//
//            }
        });
        
//        }
//        @catch (NSException * e) {
//            NSLog(@"Exception: %@", e);
//            //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
//                                                                message:@"Oops! There seems to be an issue accessing the database. Please try again."
//                                                               delegate:self
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil, nil];
//            //alertView.tag = 1;
//            [alertView show];
//
//        }
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"MMM d yyyy"];
//        NSString* string=@"Sep 28 2014";
//        NSDate *dat = [formatter dateFromString:string];
//        
//        NSString *dateString = [formatter stringFromDate:dat];
//        
//        NSLog(@"The formatted date is:%@", dateString);
        
        //[formatter setDateFormat:@"dd MM yyyy"];
        
        //-------------------------
        
        //CREATE SPONSOR OBJECTS
        #pragma mark - Create Sponsor Objects
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/sponsorsF14.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                //Set up our sponsors array
                sponsorsArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create session object
                    NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sLevel = [[json objectAtIndex:i] objectForKey:@"sponsorLevel"];
                    NSString * sSpecial = [[json objectAtIndex:i] objectForKey:@"sponsorSpecial"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"sponsorName"];
                    NSString * bNumber = [[json objectAtIndex:i] objectForKey:@"boothNumber"];
                    NSString * sWebsite = [[json objectAtIndex:i] objectForKey:@"sponsorWebsite"];
                    NSString * sImage = [[json objectAtIndex:i] objectForKey:@"sponsorImage"];
                    NSString * sSeries = [[json objectAtIndex:i] objectForKey:@"series"];
                    
                    Sponsors   * mySponsors = [[Sponsors alloc] initWithSponsorID: sID andSponsorLevel: sLevel andSponsorSpecial: sSpecial andSponsorName: sName andBoothnumber: bNumber andSponsorWebsite:sWebsite andSponsorImage:sImage andSeries:sSeries];
                    
                    //Add our sessions object to our exhibitHallArray
                    [sponsorsArray addObject:mySponsors];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sponsors" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sponsorID == %@",mySponsors.sponsorID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sponsors" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:mySponsors.sponsorName forKey:@"sponsorName"];
                        //NSString * sIdStr = [[NSString alloc]initWithFormat:@"%@", mySponsors.sponsorID];
                        
                        [newManagedObject setValue:mySponsors.sponsorID forKey:@"sponsorID"];
                        [newManagedObject setValue:mySponsors.sponsorLevel forKey:@"sponsorLevel"];
                        [newManagedObject setValue:mySponsors.sponsorSpecial forKey:@"sponsorSpecial"];
                        [newManagedObject setValue:mySponsors.sponsorImage forKey:@"sponsorImage"];
                        [newManagedObject setValue:mySponsors.sponsorWebsite forKey:@"sponsorWebsite"];
                        [newManagedObject setValue:mySponsors.boothNumber forKey:@"boothNumber"];
                        [newManagedObject setValue:mySponsors.series forKey:@"series"];
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Sponsor object!");
                    }
                    
                    
                    
                    
                }
                
                
            });
        });
        
        
        //    //-------------------------
        
        //CREATE CSCHEDULE OBJECTS
        #pragma mark - Create CSchedule Objects
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/cscheduleW15.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //Set up our cschedule array
                cscheduleArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create cschedule object
                    NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sDate = [[json objectAtIndex:i] objectForKey:@"date"];
                    NSString * sDay = [[json objectAtIndex:i] objectForKey:@"day"];
                    NSString * sTrueDate = [[json objectAtIndex:i] objectForKey:@"trueDate"];
                    
                    
                    CSchedule * myCschedule = [[CSchedule alloc] initWithID: sID andDate: sDate andDay: sDay andTrueDate: sTrueDate];
                    
                    
                    //Add our exhibitors object to our exhibitorsArray
                    [cscheduleArray addObject:myCschedule];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cschedule" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %@",myCschedule.ID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Cschedule" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:myCschedule.ID forKey:@"id"];
                        
                        [newManagedObject setValue:myCschedule.day forKey:@"day"];
                        
                        [newManagedObject setValue:myCschedule.date forKey:@"date"];
                        
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"MMM dd yyyy"];
                        NSDate *csDate = [df dateFromString: myCschedule.trueDate];
                        [newManagedObject setValue:csDate forKey:@"trueDate"];
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Cschedule object!");
                    }
                    
                    
                }
                
                
                
            });
        });

        //    //-------------------------
        
        //CREATE EHSCHEDULE OBJECTS
        #pragma mark - Create EHSchedule Objects
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/ehscheduleW15.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //Set up our ehschedule array
                exhibitHallArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create cschedule object
                    NSString * sID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * sDate = [[json objectAtIndex:i] objectForKey:@"scheduleDate"];
                    NSString * sName = [[json objectAtIndex:i] objectForKey:@"sessionName"];
                    NSString * sTime = [[json objectAtIndex:i] objectForKey:@"sessionTime"];
                    NSString * sStartTime = [[json objectAtIndex:i] objectForKey:@"startTime"];
                    
                    
                    EHSchedule * myEhschedule = [[EHSchedule alloc] initWithScheduleID: sID andScheduleDate:sDate andSessionName: sName andSessionTime: sTime andStartTime: sStartTime];
                    
                    
                    //Add our exhibitors object to our exhibitorsArray
                    [exhibitHallArray addObject:myEhschedule];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ehschedule" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %@",myEhschedule.scheduleID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Ehschedule" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:myEhschedule.scheduleID forKey:@"id"];
                        
                        [newManagedObject setValue:myEhschedule.sessionName forKey:@"sessionName"];
                        
                        [newManagedObject setValue:myEhschedule.sessionTime forKey:@"sessionTime"];
                        
                        [newManagedObject setValue:myEhschedule.scheduleDate forKey:@"scheduleDate"];
                        
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"hh:mm a"];
                        NSDate *ehStartTime = [df dateFromString: myEhschedule.startTime];
                        [newManagedObject setValue:ehStartTime forKey:@"startTime"];
                        
                        
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Cschedule object!");
                    }
                    
                    
                }
                
                
                
            });
        });

        //    //-------------------------
        
        //CREATE HTML OBJECTS
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            
            NSURL *url = [NSURL URLWithString:@"http://speedyreference.com/html.php"];
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                //Set up our Html array
                htmlArray = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < json.count; i++) {
                    //create Html object
                    NSString * hID = [[json objectAtIndex:i] objectForKey:@"id"];
                    NSString * hName = [[json objectAtIndex:i] objectForKey:@"name"];
                    NSString * hUrl = [[json objectAtIndex:i] objectForKey:@"url"];
                    
                    
                    Html * myHtml = [[Html alloc] initWithID: hID andName:hName andUrl: hUrl];
                    
                    
                    //Add our html object to our htmlArray
                    [htmlArray addObject:myHtml];
                    
                    NSManagedObjectContext *context = [self managedObjectContext];
                    
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Html" inManagedObjectContext:context];
                    
                    [fetchRequest setEntity:entity];
                    
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %@",myHtml.ID]];
                    
                    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
                    
                    self.objects = myResults;
                    if (!myResults || !myResults.count){
                        
                        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Html" inManagedObjectContext:context];
                        
                        [newManagedObject setValue:myHtml.ID forKey:@"id"];
                        
                        [newManagedObject setValue:myHtml.name forKey:@"name"];
                        
                        [newManagedObject setValue:myHtml.url forKey:@"url"];
                        
                        NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSLog(@"You created a new Html object!");
                    }
                    
                    
                }
                
                
                
            });
        });

   
        
        
    }//END REACHABILITY ELSE
    
    
    
    
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

//maaj code 062313
- (void) refreshTable {
    
    printf("\n Refresh is called \n");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //NSManagedObjectContext *managedObjectContext = [self.coreDataStore contextForCurrentThread];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

#pragma mark - Core Data Objects and methods

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


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    [FBSession.activeSession handleDidBecomeActive];
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make an internet connection at this time. Some functionality will be limited until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
            break;
        }
            
    }

    
    application.applicationIconBadgeNumber = 0;
    
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession close];
}

#pragma mark - Setup Push Methods

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken
{
    //[[PushIOManager sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //[[PushIOManager sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    //-------------------------------------//
    //For showing tabbar badge value
    //Added by Maaj
    iNotificationCounter++;
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UITabBarItem *tabBarItem2 = [[[tabBarController tabBar] items] objectAtIndex:1];
    tabBarItem2.badgeValue = [NSString stringWithFormat:@"%d",iNotificationCounter];
    //-------------------------------------//
    //Parse handle
    [PFPush handlePush:userInfo];
    
    //[[PushIOManager sharedInstance] didReceiveRemoteNotification:userInfo];
    
    NSDictionary *payload = [userInfo objectForKey:@"aps"];
    
    NSString *alertMessage = [payload objectForKey:@"alert"];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
        [alertView show];
    
    
    //Save to plist
    
    //NSDate *now = [NSDate date];
    
    if([clName count] == 5)
        [clName removeObjectAtIndex:0];
    [clName addObject:alertMessage];
    //[clName addObject:now];
    
    
	// get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
	
	// This writes the array to a plist file. If this file does not already exist, it creates a new one.
	[clName writeToFile:plistPath atomically: TRUE];
    
    
    
    
}

- (void)readyForRegistration
{
    // If this method is called back, PushIOManager has a proper device token
    // so now you are ready to register.
}

- (void)registrationSucceeded
{
    // Push IO registration was successful
}

- (void)registrationFailedWithError:(NSError *)error statusCode:(int)statusCode
{
    // Push IO registration failed
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    printf("Reachability"); //maaj code 062313
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make an internet connection at this time. Some functionality will be limited until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //[alert release];
            break;
        }
    }

}

- (void)serviceStarted
{
    // this will be invoked if the service has successfully started
    // bluetooth scanning will be started at this point.
    NSLog(@"FYX Service Successfully Started");
}

- (void)startServiceFailed:(NSError *)error
{
    // this will be called if the service has failed to start
    NSLog(@"%@", error);
}

# pragma mark - Updates user's current location

-(void)updateCurrentLocation {
    [self.customLocationManager startUpdatingLocation];
}

-(void)stopUpdatingCurrentLocation {
    [self.customLocationManager stopUpdatingHeading];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentUserLocation = newLocation;
    
    [self.customLocationManager stopUpdatingLocation];
    self.currentUserLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude
                                                          longitude:newLocation.coordinate.longitude];
}

# pragma mark - Setup SpeechKit Connection

- (void)setupSpeechKitConnection {
    
    [SpeechKit setupWithID:@"NMDPTRIAL_bjulien20140508222743"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:nil];
    
    // Set earcons to play
    SKEarcon* earconStart	= [SKEarcon earconWithName:@"earcon_listening.wav"];
    SKEarcon* earconStop	= [SKEarcon earconWithName:@"earcon_done_listening.wav"];
    SKEarcon* earconCancel	= [SKEarcon earconWithName:@"earcon_cancel.wav"];
    
    [SpeechKit setEarcon:earconStart forType:SKStartRecordingEarconType];
    [SpeechKit setEarcon:earconStop forType:SKStopRecordingEarconType];
    [SpeechKit setEarcon:earconCancel forType:SKCancelRecordingEarconType];
}



//- (void)didArrive:(FYXVisit *)visit;
//{
//    if ([visit.transmitter.name isEqualToString:@"BICSIBeacon1"]) {
//        
//        
//        // this will be invoked when an authorized transmitter is sighted for the first time
//        NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
//        //
//        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"I arrived at a BICSIBeacon1!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        //[alert show];
//        
//        
//        
//        UIApplication *app                = [UIApplication sharedApplication];
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//        
//        
//        if (notification == nil)
//            return;
//        notification.alertBody = [NSString stringWithFormat: NSLocalizedString(@"Hi there! Please stop by the BICSI Cares booth and show your support.", nil) ];
//        notification.alertAction = NSLocalizedString (@"BICSI Cares", nil);
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        notification.applicationIconBadgeNumber = 1;
//        [app presentLocalNotificationNow:notification];
//        
//    }
//    
//    if ([visit.transmitter.name isEqualToString:@"BICSIBeacon2"]){
//        
//        // this will be invoked when an authorized transmitter is sighted for the first time
//        NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
//        //
//        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"I arrived at a BICSIBeacon2!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        //[alert show];
//        
//        
//        
//        UIApplication *app                = [UIApplication sharedApplication];
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
//        
//        
//        if (notification == nil)
//            return;
//        notification.alertBody = [NSString stringWithFormat: NSLocalizedString(@"Hi there! Please stop by the BICSI Store and check out the sales on gear and publications!", nil) ];
//        notification.alertAction = NSLocalizedString (@"BICSI Store", nil);
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        notification.applicationIconBadgeNumber = 1;
//        [app presentLocalNotificationNow:notification];
//        
//    }
//    
//}
//- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
//{
//    // this will be invoked when an authorized transmitter is sighted during an on-going visit
//    NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
//}
//- (void)didDepart:(FYXVisit *)visit;
//{
//    // this will be invoked when an authorized transmitter has not been sighted for some time
//    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
//    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
//}


//-(void)managedObjectFunction{
//    
//    
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"appalert" withExtension:@"momd"];
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alerts" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    
//    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
//    //[self.refreshControl endRefreshing];
//    self.objects = results;
//    
//    NSLog(@"News & Alerts results = %lu", (unsigned long)results.count);
//    
//    if (!results || !results.count){
//        NSLog(@"No results");
//    }
//
//    
//    
//}

@end
