//
//  ConfSchedTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSchedule.h"

@class ConfSchedTableViewController;

@protocol ConfSchedTableViewControllerDelegate

@end

@interface ConfSchedTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * confSchedArray;
@property (nonatomic, strong) NSMutableArray * results;
//@property BOOL isFiltered;

@property (weak, nonatomic) id <ConfSchedTableViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *objects;

//#pragma mark - Methods
//-(void) retrieveData;
//- (void)fetchedData:(NSData *)responseData;

@end
