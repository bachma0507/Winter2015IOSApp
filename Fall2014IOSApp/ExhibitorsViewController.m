//
//  ExhibitorsViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "ExhibitorsDetailViewController.h"
#import "MBProgressHUD.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "StartPageViewController.h"
#import "ExhibitorViewCell.h"

@interface ExhibitorsViewController ()

@end

//#define getDataURL @"http://speedyreference.com/JSON/document.json"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/JSON/document.json"] //2

@implementation ExhibitorsViewController
@synthesize json, exhibitorsArray, myTableView, results, objects;

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
    
    [TestFlight passCheckpoint:@"ExhbitorsTable-info-viewed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"billow"]];
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
    
    
    //[self.myTableView reloadData];
    
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
    
    
    NSPredicate * resultsPredicate = [NSPredicate predicateWithFormat:@"name contains [cd] %@", self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resultsPredicate] mutableCopy];
    
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [self searchThroughData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [exhibitorsArray count];
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
    static NSString *CellIdentifier = @"ExhibitorsCell";
    
    
     ExhibitorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor = [UIColor colorWithRed:16/255.0 green:29/255.0 blue:60/255.0 alpha:1.0];
    
    if (!cell) {
        cell = [[ExhibitorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //exhibitors * myexhibitors = nil;
    
    if (tableView == self.myTableView){
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    //myexhibitors = [exhibitorsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    //cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    //cell.textLabel.textColor = [UIColor colorWithRed:152/255.0 green:142/255.0 blue:79/255.0 alpha:1.0];
        NSString * fav = [NSString stringWithFormat:@"%@", [object valueForKey:@"fav"]];
        //NSString * favName = [NSString stringWithFormat:@"%@", [object valueForKey:@"name"]];
        
        if ([fav isEqualToString:@"Yes"]) {
            
            cell.textLabel.textColor = [UIColor redColor];
            
            UIImage * myImage = [UIImage imageNamed:@"star_red_120.png"];
            
            [cell.starUnSel setImage:myImage];
        }
        else{
        
        cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
            
            UIImage * myImage2 = [UIImage imageNamed:@"transparent.png"];
            
            [cell.starUnSel setImage:myImage2];
        }
        
    NSString * booth = [NSString stringWithFormat:@"Booth Number: %@", [object valueForKey:@"boothLabel"]];
    cell.detailTextLabel.text = booth;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    }
    else{
        
    //myexhibitors = [results objectAtIndex:indexPath.row];
    NSManagedObject *object = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    //cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    //cell.textLabel.textColor = [UIColor brownColor];
        NSString * fav = [NSString stringWithFormat:@"%@", [object valueForKey:@"fav"]];
        
        if ([fav isEqualToString:@"Yes"]) {
            
            cell.textLabel.textColor = [UIColor redColor];
            
            UIImage * myImage = [UIImage imageNamed:@"star_red_120.png"];
            
            [cell.starUnSel setImage:myImage];
        }
        else{
            
            cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
            
            UIImage * myImage2 = [UIImage imageNamed:@"transparent.png"];
            
            [cell.starUnSel setImage:myImage2];
        }
        
    NSString * booth = [NSString stringWithFormat:@"Booth Number: %@", [object valueForKey:@"boothLabel"]];
    cell.detailTextLabel.text = booth;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
    }
    
    return cell;
}



-(void)refreshTable{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
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
        [self performSegueWithIdentifier:@"exhibitDetailCell" sender:self];
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"exhibitDetailCell"]) {
        
        
        if (self.searchDisplayController.isActive) {
            NSIndexPath * indexPath = [[self.searchDisplayController searchResultsTableView] indexPathForSelectedRow];
        ExhibitorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.myExhibitors = [results objectAtIndex:indexPath.row];
        }
        else{
        
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        ExhibitorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.myExhibitors = [objects objectAtIndex:indexPath.row];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Exhibitors" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                            init];
        
        [refreshControl endRefreshing];
        self.objects = myResults;
        [self.myTableView reloadData];
    
    
}

//-(void)updateData{
//    StartPageViewController * startPage = [[StartPageViewController alloc] init];
//    
//    [startPage updateAllData];
//    
//    
//    
//}


//- (IBAction)starPressed:(id)sender {
//    
//    ExhibitorsDetailViewController * exDetail = [[ExhibitorsDetailViewController alloc] init];
//    
//    [exDetail favPressed];
//}
@end

