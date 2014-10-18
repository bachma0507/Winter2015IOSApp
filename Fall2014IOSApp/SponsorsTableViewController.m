//
//  SponsorsTableViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SponsorsTableViewController.h"
#import "SponsorsDetailViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "MBProgressHUD.h"


@interface SponsorsTableViewController ()

@end

//#define getDataURL @"http://speedyreference.com/sponsors.php"
//#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
//#define getDataURL [NSURL URLWithString: @"http://speedyreference.com/sponsors.php"] //2

@implementation SponsorsTableViewController

@synthesize json;
@synthesize sponsorsArray;
@synthesize results;
@synthesize objects;
@synthesize myTableView;


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TestFlight passCheckpoint:@"SponsorsTable-info-viewed"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amazonas"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
//        HUD = [[MBProgressHUD alloc] initWithView:self.view];
//        HUD.labelText = @"Loading data...";
//        //HUD.detailsLabelText = @"Just relax";
//        HUD.mode = MBProgressHUDAnimationFade;
//        [self.view addSubview:HUD];
//        [HUD showWhileExecuting:@selector(waitForTwoSeconds) onTarget:self withObject:nil animated:YES];
    
//    dispatch_async(kBgQueue, ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        getDataURL];
//        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
//    });
    

    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    [HUD show:YES];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];

    
}

//- (void)waitForTwoSeconds {
//    sleep(2);
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshTable{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sponsors" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"series CONTAINS 'F14'"]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"series" ascending:YES];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SponsorCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SponsorsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SponsorsViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    // Configure the cell...
    
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    
    //Sponsors * sponsors = nil;
    
    //sponsors = [sponsorsArray objectAtIndex:indexPath.row];
    
    cell.sponsorName.text = [object valueForKey:@"sponsorName"];
    cell.sponsorName.font = [UIFont fontWithName:@"Arial" size:13.0];
    cell.sponsorName.textColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
    
    cell.sponsorLevel.text = [object valueForKey:@"sponsorLevel"];
    cell.sponsorLevel.font = [UIFont fontWithName:@"Arial" size:12.0];
    cell.sponsorLevel.textColor = [UIColor whiteColor];
    
    cell.sponsorSpecial.text = [object valueForKey:@"sponsorSpecial"];
    cell.sponsorSpecial.font = [UIFont fontWithName:@"Arial" size:8.0];
    
    cell.boothNumber.text = [object valueForKey:@"boothNumber"];
    cell.boothNumber.font = [UIFont fontWithName:@"Arial" size:11.0];
    cell.boothNumber.textColor = [UIColor whiteColor];
    


    
//        cell.sponsorName.userInteractionEnabled = YES;
//        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
//        [cell.sponsorName addGestureRecognizer:gr];
//        gr.numberOfTapsRequired = 1;
//        gr.cancelsTouchesInView = NO;
//        [self.view addSubview:cell.sponsorName];
    
    return cell;

}

//- (void) openUrl: (UITapGestureRecognizer *) gr {
//    NSURL *url = [NSURL URLWithString:@"http://www.bicsi.org"];
//	[[UIApplication sharedApplication] openURL:url];
//}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.row % 2 == 0){
//        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
//        cell.backgroundColor = altCellColor;
//    }
//    else{
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SponsorDetailCell"]) {
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        SponsorsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.sponsors = [self.objects objectAtIndex:indexPath.row];
        
    }
}


@end
