//
//  MoreViewController.h
//  BICSIapp
//
//  Created by Barry on 4/25/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
