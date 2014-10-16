//
//  PlistViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/5/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlistViewController : UIViewController

{
    NSMutableArray	*array;
	
	UITableView		*myTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@end
