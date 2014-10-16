//
//  ConfSchedDetailTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSchedule.h"
#import "confSchedDetailViewCell.h"
#import "Sessions.h"

@interface ConfSchedDetailTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *myObjects;

//@property (nonatomic, strong) NSMutableArray * results;

@property (nonatomic, strong) CSchedule * cschedule;
@property (nonatomic, strong) Sessions * mySessions;

@end
