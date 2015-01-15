//
//  AllMyNotesViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AllMyNotesViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
//#import "StackMob.h"
#import "AllNotesCell.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AllMyNotesViewController ()

@end

@implementation AllMyNotesViewController

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

//- (Fall2013IOSAppAppDelegate *)appDelegate {
//    return (Fall2013IOSAppAppDelegate *)[[UIApplication sharedApplication] delegate];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
//    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"billow"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);


    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    
    [self refreshTable];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AllNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    cell.sessionNoteLabel.text = [object valueForKey:@"sessionname"];
    cell.sessionNoteDesc.text = [object valueForKey:@"notes"];
//    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
    cell.sessionNoteLabel.numberOfLines = 4;
    
    [[cell.sessionNoteDesc layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[cell.sessionNoteDesc layer] setBorderWidth:2.3];
    [[cell.sessionNoteDesc layer] setCornerRadius:10];
    [cell.sessionNoteDesc setClipsToBounds: YES];
    
    
    return cell;

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row % 2 == 0){
        //UIColor *altCellColor = [UIColor colorWithRed:235/255.0 green:240/255.0 blue:233/255.0 alpha:1.0];
        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}


- (void) refreshTable {
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"deviceowner == %@ && sessionname != null && notes != null", newDeviceID]];
    //NSError *error = nil;
    //NSArray *array = [self executeFetchRequest:fetchRequest error:&error];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sessionname" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
     NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!results || !results.count) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        NSURL *fileURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds/Modern/sms_alert_bamboo.caf"]; // see list below
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
        AudioServicesPlaySystemSound(soundID);
        
        NSString *message = @"You have not added any Session Notes. Please click on Notes when viewing Session details.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
    }

    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        [self.refreshControl endRefreshing];
        self.objects = results;
        [self.tableView reloadData];
        
//    } onFailure:^(NSError *error) {
//        
//        [self.refreshControl endRefreshing];
//        NSLog(@"An error %@, %@", error, [error userInfo]);
//    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        //NSManagedObjectContext *context = [[[self appDelegate] coreDataStore] contextForCurrentThread];
        
        NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        [context deleteObject:[context objectWithID:[object objectID]]];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        //[context saveOnSuccess:^{
       //     NSLog(@"The delete was successful!");
//        } onFailure:^(NSError *error) {
//            NSLog(@"The save wasn't successful: %@", [error localizedDescription]);
//        }];
        
        NSMutableArray *array = [self.objects mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        self.objects = array;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

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

@end
