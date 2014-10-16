//
//  ExhibitHallScheduleViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHSchedule.h"
#import "ExhibitHallScheduleCell.h"

@interface ExhibitHallScheduleViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * exhibitHallArray;
@property (nonatomic, strong) NSMutableArray * results;
//@property BOOL isFiltered;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray *objects;

//#pragma mark - Methods
//-(void) retrieveData;
//- (void)fetchedData:(NSData *)responseData;

@end
