//
//  PlistTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/25/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlistTableViewController : UITableViewController


{
    NSMutableArray	*array;
	
	UITableView		*myTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
