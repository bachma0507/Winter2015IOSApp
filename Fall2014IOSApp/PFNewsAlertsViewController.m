//
//  PFNewsAlertsViewController.m
//  Canada2014IOSApp
//
//  Created by Barry on 2/22/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "PFNewsAlertsViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "AppConstant.h"

extern int iNotificationCounter;

@interface PFNewsAlertsViewController ()

@end

@implementation PFNewsAlertsViewController

//int iNotificationCounter=0;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Alerts";
        self.textKey = @"text";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    
    //NSLog(@"initWithCoder method is called");
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Wipe out old user defaults
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"billow"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"objectIDArray"]){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"objectIDArray"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Simple way to create a user or log in the existing user
    // For your app, you will probably want to present your own login screen
    PFUser *currentUser = [PFUser currentUser];
    
    if (!currentUser) {
        // Dummy username and password
        PFUser *user = [PFUser user];
        user.username = @"Matt";
        user.password = @"password";
        user.email = @"Matt@example.com";
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                // Assume the error is because the user already existed.
                [PFUser logInWithUsername:@"Matt" password:@"password"];
            }
        }];
    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    //    if ([self.objects count] == 0) {
    //        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    //    }
    //
    [query orderByDescending:@"createdAt"];
    
    //NSLog(@"OFQuery method is called");
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    //PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    cell.textLabel.text = [object objectForKey:@"text"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.numberOfLines = 4;
    
    
//    NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
//    [timeFormatter1 setDateFormat:@"MMM dd yyyy, hh:mm"];
//    NSDate * cDate = [object objectForKey:@"createdAt"];
//    NSString *mycDate = [timeFormatter1 stringFromDate:cDate];
//    
//    NSLog(@"PF_ALERTS_CREATEDAT is: %@", mycDate);
//    
//    cell.detailTextLabel.text = mycDate;
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
   
    
    //NSLog(@"UITableView method is called");
    
    return cell;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[self refreshTable];
    //[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refreshTable) userInfo:nil repeats:YES];
    
    //For reseting the tabbar badge value
    //Added by Maaj
    UITabBarController *tBar = (UITabBarController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    UITabBarItem *item=[[[tBar tabBar] items] objectAtIndex:1];
    [item setBadgeValue:nil];
    iNotificationCounter = 0;
    //----------------------------------------------//
    
}




@end
