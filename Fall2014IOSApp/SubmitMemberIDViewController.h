//
//  SubmitMemberIDViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 8/5/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Functions.h"
#import <CoreData/CoreData.h>


@class MBProgressHUD;

@interface SubmitMemberIDViewController : UIViewController

{
    MBProgressHUD *HUD;
    
}

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * functionsArray;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) NSArray *objects;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (IBAction)loginClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;


@end
