//
//  SponsorsTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sponsors.h"
#import "SponsorsViewCell.h"
@class MBProgressHUD;

@interface SponsorsTableViewController : UITableViewController 

{
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * sponsorsArray;
@property (nonatomic, strong) NSMutableArray * results;

@property (strong, nonatomic) NSArray *objects;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;


//#pragma mark - Methods
//- (void)fetchedData:(NSData *)responseData;
//- (void)retrieveData;


@end
