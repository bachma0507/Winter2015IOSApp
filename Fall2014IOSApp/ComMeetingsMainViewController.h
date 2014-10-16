//
//  ComMeetingsMainViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 2/15/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"
#import "SessionsViewController.h"
@class MBProgressHUD;

@class ComMeetingsMainViewController;

@protocol ComMeetingsMainViewControllerDelegate

@end

@interface ComMeetingsMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) id <ComMeetingsMainViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray * results;

@property (strong, nonatomic) NSArray *objects;

@property (strong, nonatomic) NSArray *dateArray;
@property (strong, nonatomic) NSMutableDictionary *tempDict;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
