//
//  ConfSchedDetailTableViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ConfSchedDetailTableViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import <CoreData/CoreData.h>
#import "SessionsDetailViewController.h"


@interface ConfSchedDetailTableViewController ()

@end

@implementation ConfSchedDetailTableViewController
@synthesize myObjects;
@synthesize cschedule, mySessions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = cschedule.date;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amazonas"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        //UIColor *altCellColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:233/255.0 alpha:1.0];
        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.myObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"confSchedDetailCell";
    
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    confSchedDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (!cell)
    {
        cell = [[confSchedDetailViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    
    
    NSManagedObject *object = [self.myObjects objectAtIndex:indexPath.row];
    cell.sessionName.text = [object valueForKey:@"sessionName"];
    
    NSString * planner = [NSString stringWithFormat:@"%@", [object valueForKey:@"planner"]];
    
    if ([planner isEqualToString:@"Yes"]) {
        
        cell.sessionName.textColor = [UIColor redColor];
    }
    else{
        
        cell.sessionName.textColor = [UIColor brownColor];
    }
    
    
    
    NSDate * sTime = [object valueForKey:@"startTime"];
    NSDate * eTime = [object valueForKey:@"endTime"];
    
    NSDateFormatter *sdf = [[NSDateFormatter alloc]init];
    [sdf setDateFormat:@"hh:mm a"];
    NSString *sTimeStr = [sdf stringFromDate:sTime];
    
    NSDateFormatter *edf = [[NSDateFormatter alloc]init];
    [edf setDateFormat:@"hh:mm a"];
    NSString *eTimeStr = [sdf stringFromDate:eTime];
    
    NSString * sessionTime = [[NSString alloc] initWithFormat:@"%@ - %@", sTimeStr, eTimeStr];
    
    cell.sessionTime.text = sessionTime;
    cell.itscecs.hidden = YES;
    cell.sessionStatus.hidden = YES;
    //cell.sessionStatus.text = [object valueForKey:@"sessionStatus"];
    
//    NSString *itscecsStr = [[NSString alloc] initWithFormat:@"%@",[object valueForKey:@"itscecs"]];
//    if ([itscecsStr isEqual: @"3"]) {
//        cell.itscecs.text = @"ITS CECs: 3";
//    }
//    else if([itscecsStr isEqual: @"6"]){
//        cell.itscecs.text = @"ITS CECs: 6";
//    }
//    else{
//    cell.itscecs.text = @" ";
//    }
    
    //cell.itscecs.text =[object valueForKey:@"itscecs"];
    //cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    //cell.textLabel.font = [UIFont fontWithName:@"Arial-Bold" size:10.0];
    //cell.textLabel.font = [UIFont systemFontOfSize:11.0];
    //cell.textLabel.textColor = [UIColor brownColor];
    
    //cell.textLabel.numberOfLines = 0;
    //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    
    // Configure the cell...
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    SessionsDetailViewController *aViewController = [[SessionsDetailViewController alloc] initWithNibName:@"SessionsDetailViewController" bundle:nil];
//    UIPopoverController *popoverController = [[UIPopoverController alloc]
//                                              initWithContentViewController:aViewController];
//    
//    popoverController.popoverContentSize = CGSizeMake(320, 416);
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [popoverController presentPopoverFromRect:cell.bounds inView:cell.contentView
//                     permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//}

-(void)refreshTable{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"NOT(sessionID CONTAINS 'EXHV' || sessionID CONTAINS 'EXHX' || sessionID CONTAINS 'DRIN' || sessionID CONTAINS 'BADG' || sessionID CONTAINS 'CRED_H' || sessionID CONTAINS 'FTA' || sessionID CONTAINS 'GUES' || sessionID CONTAINS 'INTL' || sessionID CONTAINS 'NEW_' || sessionID CONTAINS 'GS_TUESA' || sessionID CONTAINS 'GS_TUESP' || sessionID CONTAINS 'GS_THURA' || sessionID CONTAINS 'OD_') && sessionDate == %@",cschedule.trueDate]];
    
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"NOT(sessionID CONTAINS 'BODMC')"]];
    
    
    NSLog(@"cshedule date in refreshtable is: %@",cschedule.date);
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSArray *myResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    self.myObjects = myResults;
    
    if (!myResults || !myResults.count){
        NSLog(@"No results!");
    }
    else{
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                            init];
        
        [refreshControl endRefreshing];
        self.myObjects = myResults;
        

    }
    
    [self.tableView reloadData];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"sessionsDetailCell"])
    {
        
                        
            NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
            SessionsDetailViewController *destViewController = segue.destinationViewController;
            destViewController.mySessions = [self.myObjects objectAtIndex:indexPath.row];
            
            
        }
    
}


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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}

@end
