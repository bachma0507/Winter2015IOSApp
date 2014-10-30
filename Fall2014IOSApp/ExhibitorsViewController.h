//
//  ExhibitorsViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exhibitors.h"
#import "ExhibitorsDetailViewController.h"
@class MBProgressHUD;

@interface ExhibitorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

{
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * exhibitorsArray;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray * results;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *objects;

//- (IBAction)starPressed:(id)sender;


//- (void)fetchedData:(NSData *)responseData;
//-(void)retrieveData;


@end
