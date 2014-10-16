//
//  AgendaDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AgendaDetailViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"


@interface AgendaDetailViewController ()

@end

@implementation AgendaDetailViewController
@synthesize sessionId, sessionName, sessionNameLabel, sessionIdLabel, location, locationLabel;

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


//- (Fall2013IOSAppAppDelegate *)appDelegate {
//    return (Fall2013IOSAppAppDelegate *)[[UIApplication sharedApplication] delegate];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    sessionNameLabel.text = self.sessionName;
    sessionIdLabel.text = self.sessionId;
    locationLabel.text = self.location;
    
    [[sessionNameLabel layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[sessionNameLabel layer] setBorderWidth:1.0];
    [[sessionNameLabel layer] setCornerRadius:10];
    //[sessionNameLabel setClipsToBounds: YES];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takeSurvey:(id)sender{
    
    NSString * sessIDStr = [[NSString alloc]initWithFormat:@"%@",self.sessionId];
    
    if ([sessIDStr hasPrefix:@"COM"] || [sessIDStr hasPrefix:@"EH"] || [sessIDStr hasPrefix:@"BREAK"] || [sessIDStr hasPrefix:@"ATT"] || [sessIDStr hasPrefix:@"BIC"] || [sessIDStr hasPrefix:@"CRED"] || [sessIDStr hasPrefix:@"EX"] || [sessIDStr hasPrefix:@"GS_CALL"] || [sessIDStr hasPrefix:@"GUE"] || [sessIDStr hasPrefix:@"CONF"]) {
        NSString *message = @"Survey not applicable for this meeting.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
    }
    
    else{
        
        NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", self.sessionId];
        //    NSURL *url = [NSURL URLWithString:myURL];
        //	[[UIApplication sharedApplication] openURL:url];
        NSURL *URL = [NSURL URLWithString:myURL];
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"notesDetail"]) {
//        self.sessionName = sessionNameLabel.text;
//        self.sessionId = sessionIdLabel.text;
//        
//        NotesViewController *destViewController = segue.destinationViewController;
//        destViewController.title = sessionNameLabel.text;
//        destViewController.sessionName = self.sessionName;
//        destViewController.sessionId = self.sessionId;
//        
//        NSLog(@"Session ID is %@", self.sessionId);
//    }
//}

#pragma mark - Notes View Controller

- (void)NotesViewControllerDidFinish:(NotesViewController *)controller
{
    [self.NotesPopoverController dismissPopoverAnimated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.NotesPopoverController = nil;
    self.SurveyPopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        if ([segue.identifier isEqualToString:@"notesDetail"]) {
            self.sessionName = sessionNameLabel.text;
                    self.sessionId = sessionIdLabel.text;
            
                    NotesViewController *destViewController = segue.destinationViewController;
                    destViewController.title = sessionNameLabel.text;
                    destViewController.sessionName = self.sessionName;
                    destViewController.sessionId = self.sessionId;
            
                    NSLog(@"Session ID is %@", self.sessionId);
        }
        
        
        
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if ([[segue identifier] isEqualToString:@"notesDetail"]) {
            
            self.sessionName = sessionNameLabel.text;
            self.sessionId = sessionIdLabel.text;
            
            NotesViewController *destViewController = segue.destinationViewController;
            destViewController.title = sessionNameLabel.text;
            destViewController.sessionName = self.sessionName;
            destViewController.sessionId = self.sessionId;
            
            
            [[segue destinationViewController] setDelegate:self];
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.NotesPopoverController = popoverController;
            popoverController.delegate = self;
        }
        
        else if ([[segue identifier] isEqualToString:@"surveyDetail"]) {
            
            //self.sessionName = sessionNameLabel.text;
            //self.sessionId = mySessions.sessionID;
            SurveyViewController *destViewController = segue.destinationViewController;
            //destViewController.title = sessionNameLabel.text;
            //destViewController.sessionName = self.sessionName;
            destViewController.sessionId = self.sessionId;
            
            NSLog(@"****SessionID in SessionsViewController popover segue to SurveyViewController is %@",self.sessionId);
            
            [[segue destinationViewController] setDelegate:self];
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.SurveyPopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}


- (IBAction)togglePopover:(id)sender
{
    if (self.NotesPopoverController) {
        [self.NotesPopoverController dismissPopoverAnimated:YES];
        self.NotesPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"notesDetail" sender:sender];
    }
}

#pragma mark - Survey View Controller

- (void)SurveyViewControllerDidFinish:(SurveyViewController *)controller
{
    [self.SurveyPopoverController dismissPopoverAnimated:YES];
}


- (IBAction)togglePopoverSurvey:(id)sender
{
    if (self.SurveyPopoverController) {
        [self.SurveyPopoverController dismissPopoverAnimated:YES];
        self.SurveyPopoverController = nil;
    } else {
        NSString * sessIDStr = [[NSString alloc]initWithFormat:@"%@",self.sessionId];
        
        if ([sessIDStr hasPrefix:@"COM"] || [sessIDStr hasPrefix:@"EH"] || [sessIDStr hasPrefix:@"BREAK"] || [sessIDStr hasPrefix:@"ATT"] || [sessIDStr hasPrefix:@"BIC"] || [sessIDStr hasPrefix:@"CRED"] || [sessIDStr hasPrefix:@"EX"] || [sessIDStr hasPrefix:@"GS_CALL"] || [sessIDStr hasPrefix:@"GUE"] || [sessIDStr hasPrefix:@"CONF"]) {
            NSString *message = @"Survey not applicable for this meeting.";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil,nil];
            [alertView show];
        }
        else{
            [self performSegueWithIdentifier:@"surveyDetail" sender:sender];
        }
    }

}



@end
