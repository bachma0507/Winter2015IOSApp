//
//  MyFavoritesDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "MyFavoritesDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "LocateOnMapViewController.h"

@interface MyFavoritesDetailViewController ()

@end

@implementation MyFavoritesDetailViewController
@synthesize boothNumber, boothNumberLabel, exhibitorName, exhibitorNameLabel, boothLabel, name, urlLabel, phoneLabel, url, phone;

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
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    exhibitorNameLabel.text = self.exhibitorName;
    boothNumberLabel.text = self.boothNumber;
    urlLabel.text = self.url;
    phoneLabel.text = self.phone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notesDetail"]) {
        self.exhibitorName = exhibitorNameLabel.text;
        self.boothNumber = boothNumberLabel.text;
        ExhibitorNotesViewController *destViewController = segue.destinationViewController;
        destViewController.title = exhibitorNameLabel.text;
        destViewController.exhibitorName = self.exhibitorName;
        destViewController.boothNumber = self.boothNumber;
        
        NSLog(@"Booth number is %@", self.boothNumber);
    }
    
    else if ([segue.identifier isEqualToString:@"locationDetail"]) {
        self.boothLabel = boothNumberLabel.text;
        self.name = exhibitorNameLabel.text;
        
        LocateOnMapViewController *destViewController = segue.destinationViewController;
        //destViewController.title = nameLabel.text;
        destViewController.boothLabel = self.boothLabel;
        destViewController.title = self.name;
        
        NSLog(@"Booth Label is %@", self.boothLabel);
    }
    
}

@end
