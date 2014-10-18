//
//  SpeakersViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SpeakerDetailViewController.h"
#import "MBProgressHUD.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "StartPageViewController.h"


@interface SpeakersViewController ()

@end

//#define getDataURL @"http://speedyreference.com/speakers.php"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/speakers.php"] //2

@implementation SpeakersViewController


@synthesize json;
@synthesize speakersArray;
@synthesize myTableView;
@synthesize results;
@synthesize objects;


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [TestFlight passCheckpoint:@"speakersTable-viewed"];
    
    //[self.navigationController.navigationBar setTranslucent:NO];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amazonas"]];
    [tempImageView setFrame:self.myTableView.frame];
    
    self.myTableView.backgroundView = tempImageView;
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    HUD.labelText = @"Loading data...";
//    //HUD.detailsLabelText = @"Just relax";
//    HUD.mode = MBProgressHUDAnimationFade;
//    [self.view addSubview:HUD];
//    [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];
    
    
    //[self retrieveData];
}


//- (void)waitForTwoSeconds {
//    sleep(1.25);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchThroughData
{
    self.results = nil;
    
    
    NSPredicate * resultsPredicate = [NSPredicate predicateWithFormat:@"speakerName contains [cd] %@", self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resultsPredicate] mutableCopy];

    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self searchThroughData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.myTableView) {
        return self.objects.count;
        
    }
    else
    {
        [self searchThroughData];
        return self.results.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
        
        //Speakers * speakers = nil;
        if (tableView == self.myTableView){
        NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
            
            NSString * firstName = [[NSString alloc] initWithFormat:@"%@", [object valueForKey:@"speakerName"]];
            NSString * lastName = [[NSString alloc] initWithFormat:@"%@", [object valueForKey:@"speakerLastName"]];
            NSString * fullName = [[NSString alloc] initWithFormat:@"%@ %@", firstName, lastName];
            //speakers = [speakersArray objectAtIndex:indexPath.row];
            cell.textLabel.text = fullName;
            cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
            cell.detailTextLabel.text = [object valueForKey:@"speakerCompany"];
           //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
            //cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14.0];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
        else
        {
            //speakers = [results objectAtIndex:indexPath.row];
            NSManagedObject *object = [results objectAtIndex:indexPath.row];
            NSString * firstName = [[NSString alloc] initWithFormat:@"%@", [object valueForKey:@"speakerName"]];
            NSString * lastName = [[NSString alloc] initWithFormat:@"%@", [object valueForKey:@"speakerLastName"]];
            NSString * fullName = [[NSString alloc] initWithFormat:@"%@ %@", firstName, lastName];
            //speakers = [speakersArray objectAtIndex:indexPath.row];
            cell.textLabel.text = fullName;
            cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
            cell.detailTextLabel.text = [object valueForKey:@"speakerCompany"];
            //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
            //cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:14.0];
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        
    
    return cell;

}

//- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
//{
//    
//    if(indexPath.row % 2 == 0){
//        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
//        cell.backgroundColor = altCellColor;
//    }
//    else{
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//}

-(void)refreshTable{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speakers" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID CONTAINS 'CONCSES' || sessionID CONTAINS 'PRECON' ||sessionID CONTAINS 'GS_THURS' || sessionID CONTAINS 'GS_TUES_' && NOT(sessionID CONTAINS 'GS_THURS_3') && NOT(sessionID CONTAINS 'GS_TUES_1')"]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"speakerName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!myResults || !myResults.count) {
        NSString *message = @"There seems to have been an error updating data. Please go back to the Home screen and press the Update Data button at the bottom of the screen.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Data Update Error"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
    }
    else{
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    
    [refreshControl endRefreshing];
    self.objects = myResults;
    [self.myTableView reloadData];
    }
}

//-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
//    
//    if (buttonIndex == 0) {
//        
//        [self updateData];
//        
//        
//    }
//    
//    
//    
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchDisplayController.isActive) {
        [self performSegueWithIdentifier:@"SpeakerDetailCell" sender:self];
    }
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SpeakerDetailCell"]) {
        //NSString *object = nil;
        //NSIndexPath *indexPath = nil;
        
        if (self.searchDisplayController.isActive) {
            NSIndexPath * indexPath = [[self.searchDisplayController searchResultsTableView] indexPathForSelectedRow];
            SpeakerDetailViewController *destViewController = segue.destinationViewController;
            destViewController.speakers = [self.results objectAtIndex:indexPath.row];

        }
        else{
        
        NSIndexPath * indexPath = [self.myTableView indexPathForSelectedRow];
        SpeakerDetailViewController *destViewController = segue.destinationViewController;
        destViewController.speakers = [self.objects objectAtIndex:indexPath.row];
        }
    }
}

//-(void)updateData{
//    StartPageViewController * startPage = [[StartPageViewController alloc] init];
//    
//    [startPage updateAllData];
//    
//}



@end
