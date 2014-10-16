//  Created by Barry on 7/12/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"
#import "SessionsViewController.h"

@interface SessionsMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray * results;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *dateArray;
@property (strong, nonatomic) NSMutableDictionary *tempDict;

@end

