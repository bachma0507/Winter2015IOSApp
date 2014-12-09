//
//  StartPageViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RNFrostedSidebar.h"
#import "exhibitors.h"
#import "Speakers.h"
#import "Sessions.h"
#import "HotelWebViewController.h"
#import "ContactUsViewController.h"
#import "CECInfoViewController.h"
#import "ExamsViewController.h"
#import <MessageUI/MessageUI.h>
#import "ProgramPDFViewController.h"
#import "FindAreaActivitiesViewController.h"
#import "FloorMapsViewController.h"
#import "ComMeetingsMainViewController.h"
#import "SurveysViewController.h"

@class MBProgressHUD;
@class Reachability;

@interface StartPageViewController : UIViewController<RNFrostedSidebarDelegate, HotelWebViewControllerDelegate, ContactUsViewControllerDelegate, CECInfoViewControllerDelegate, ExamsViewControllerDelegate,MFMailComposeViewControllerDelegate, ProgramPDFViewControllerDelegate, FindAreaActivitiesViewControllerDelegate, FloorMapsViewControllerDelegate, ComMeetingsMainViewControllerDelegate, SurveysViewControllerDelegate>
{
    MBProgressHUD *HUD;
    Reachability *internetReach;

}

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * exhibitorsArray;
@property (nonatomic, strong) NSMutableArray * speakersArray;
@property (nonatomic, strong) NSMutableArray * sessionsArray;
@property (strong, nonatomic) NSArray *objects;
//@property (strong, nonatomic) NSString *updated;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UILabel *updateLabel;


- (IBAction)buttonPressed:(id)sender;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)updateAllData;


@end
