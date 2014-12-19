//
//  Session2ViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Session2ViewController.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NotesViewController.h"
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"
#import <MessageUI/MessageUI.h>


@interface Session2ViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation Session2ViewController
@synthesize session2Label, session2DateLabel, session2TimeLabel, session2DescTextField, speakerNameLabel, speakers;
@synthesize session2DateLabelText, session2descTextFieldText, session2LabelText, session2TimeLabelText, speakerNameLabelText;
@synthesize session2Name, session2Date, session2Time, session2Desc, name, sessionId, sessionIdLabel, agendaButton;
@synthesize sessionId2;
@synthesize sessionId2Label;
@synthesize sessionName, sess2StartTime, sess2EndTime, location2, locationLabel, poll2, pollButton;

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
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    
    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //self.title = speakerNameLabelText.text;
    
    session2Label.text = self.session2Name;
    session2DateLabel.text = self.session2Date;
    session2TimeLabel.text = self.session2Time;
    session2DescTextField.text = self.session2Desc;
    speakerNameLabel.text = self.name;
    sessionId2Label.text = self.sessionId2;
    locationLabel.text = self.location2;
    NSLog(@"Session Id 2 is: %@", self.sessionId2);
    
    
    sess2StartTime = self.sess2StartTime;
    sess2EndTime = self.sess2EndTime;
    location2 = self.location2;
    poll2 = self.poll2;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        [self.pollButton setHidden:YES];
//    }
    
    if ([self.poll2  isEqual: @""]) {
        [self.pollButton setHidden:YES];
    }
    
    [[session2DescTextField layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[session2DescTextField layer] setBorderWidth:2.3];
    [[session2DescTextField layer] setCornerRadius:10];
    [session2DescTextField setClipsToBounds: YES];
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && deviceowner == %@ && agenda == 'Yes'",self.sessionId,newDeviceID]];
    NSLog(@"MY SESSION ID 2 IS: %@",self.sessionId);
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        //[self.refreshControl endRefreshing];
        self.objects = results;
        NSLog(@"Results Count is: %lu", (unsigned long)results.count);
        if (!results || !results.count){
            [self.agendaButton setTitle:@"Add to Schedule" forState:normal];
        }
        else{
            [self.agendaButton setTitle:@"Remove from Schedule" forState:normal];
        }
        
//    } onFailure:^(NSError *error) {
//        
//        //[self.refreshControl endRefreshing];
//        NSLog(@"An error %@, %@", error, [error userInfo]);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takeSurvey:(id)sender{
    NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", self.sessionId2];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)agendaButtonPressed:(id)sender {
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSLog(@"Untruncated Device ID is: %@", deviceID);
    NSLog(@"Truncated Device ID is: %@", newDeviceID);
    
    NSLog(@"MY SESSION ID IS: %@",self.sessionId2);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if ([self.agendaButton.currentTitle isEqual:@"Add to Schedule"]) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessnotes" inManagedObjectContext:context];
        
        [newManagedObject setValue:self.sessionId2 forKey:@"sessionID"];
        [newManagedObject setValue:self.session2Label.text forKey:@"sessionname"];
        [newManagedObject setValue:self.session2DateLabel.text forKey:@"sessiondate"];
        [newManagedObject setValue:self.session2TimeLabel.text forKey:@"sessiontime"];
        [newManagedObject setValue:self.locationLabel.text forKey:@"location"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"hh:mm a"];
        NSDate *sessTime = [df dateFromString: self.sess2StartTime];
        [newManagedObject setValue:sessTime forKey:@"starttime"];
        [newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
        [newManagedObject setValue:@"Yes" forKey:@"agenda"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }

        
            NSLog(@"You created a new object!");
            [agendaButton setTitle:@"Remove from Schedule" forState:normal];
        
    }
    else{//start else block
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && deviceowner == %@ && agenda == 'Yes'",self.sessionId2,newDeviceID]];
        NSLog(@"MY SESSION ID 2 IS: %@",self.sessionId2);
        
         NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        
            self.objects = results;
            NSLog(@"Results Count is: %lu", (unsigned long)results.count);
            if (!results || !results.count){//start nested if block
                [self.agendaButton setTitle:@"Add to Schedule" forState:normal];}
            else{
                NSManagedObject *object = [results objectAtIndex:0];
                [object setValue:NULL forKey:@"agenda"];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![context save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }

                
                    NSLog(@"You updated an object");
                    [self.agendaButton setTitle:@"Add to Schedule" forState:normal];

            }
        
                
    }//end nested if block
         
         
}//end else block



//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"notesDetail"]) {
//        self.session2Name = session2Label.text;
//        //self.sessionId = speakers.sessionID;
//        NotesViewController *destViewController = segue.destinationViewController;
//        destViewController.title = session2Label.text;
//        destViewController.sessionName = self.session2Name;
//        destViewController.sessionId = self.sessionId2;
//        
//        NSLog(@"Session ID 2 is %@", self.sessionId2);
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
            self.session2Name = session2Label.text;
            //self.sessionId = speakers.sessionID;
            NotesViewController *destViewController = segue.destinationViewController;
            destViewController.title = session2Label.text;
            destViewController.sessionName = self.session2Name;
            destViewController.sessionId = self.sessionId2;
            
            NSLog(@"Session ID 2 is %@", self.sessionId2);        }
        
        
        
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if ([[segue identifier] isEqualToString:@"notesDetail"]) {
            
            self.session2Name = session2Label.text;
            //self.sessionId = speakers.sessionID;
            NotesViewController *destViewController = segue.destinationViewController;
            destViewController.title = session2Label.text;
            destViewController.sessionName = self.session2Name;
            destViewController.sessionId = self.sessionId2;
            
            
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
            destViewController.sessionId = self.sessionId2;
            
            NSLog(@"****SessionID in SessionsViewController popover segue to SurveyViewController is %@",self.sessionId2);
            
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
        [self performSegueWithIdentifier:@"surveyDetail" sender:sender];
    }
}



- (IBAction)AddEvent:(id)sender {
    
    //Create the Event Store
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    
    //Check if iOS6 or later is installed on user's device *******************
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        //Request the access to the Calendar
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
            
            //Access not granted-------------
            if(!granted){
                NSString *message = @"This application cannot access your Calendar... please enable in your privacy settings.";
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                                   message:message
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil,nil];
                //Show an alert message!
                //UIKit needs every change to be done in the main queue
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alertView show];
                }
                               );
                
                //Access granted------------------
            }else{
                
                
                //Event created
                if([self createEvent:eventStore]){
                    //labelText = @"Event added!";
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success"
                                                                       message:@"Event added to your mobile device's calendar."
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil,nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alertView show];
                    }
                                   );
                    
                    //Error occured
                }else{
                    //labelText = @"Something goes wrong";
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Failure"
                                                                       message:@"There was a problem. Event not added to your calendar."
                                                                      delegate:self
                                                             cancelButtonTitle:@"Ok"
                                                             otherButtonTitles:nil,nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alertView show];
                    }
                                   );
                    
                }
                
            }
        }];
    }
    
    //Device prior to iOS 6.0  *********************************************
    else{
        
        [self createEvent:eventStore];
        
    }
    
}


//Event creation
-(BOOL)createEvent:(EKEventStore*)eventStore{
    NSString *myDateStr = [[NSString alloc]initWithFormat:@"%@",self.session2Date];
    NSString *myStartTimeStr = [[NSString alloc]initWithFormat:@"%@",self.sess2StartTime];
    NSString *myEndTimeStr = [[NSString alloc]initWithFormat:@"%@",self.sess2EndTime];
    
    NSLog(@"start time is %@",myStartTimeStr);
    NSLog(@"end time is %@",myEndTimeStr);
    
    
    NSString *sessDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr,myStartTimeStr];
    NSString *sessEndDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr, myEndTimeStr];
    NSString *sessNameStr = [[NSString alloc]initWithFormat:@"%@", self.session2Name];
    NSString *sessLocationStr = [[NSString alloc]initWithFormat:@"%@", self.location2];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd yyyy hh:mm a"];
    NSDate *sessDate = [df dateFromString: sessDateStr];
    
    NSDateFormatter *dfEnd = [[NSDateFormatter alloc] init];
    [dfEnd setDateFormat:@"MMM dd yyyy hh:mm a"];
    NSDate *sessEndDate = [df dateFromString: sessEndDateStr];
    
    
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = sessNameStr;
    event.startDate = sessDate;
    //event.endDate = [event.startDate dateByAddingTimeInterval:3600];
    event.endDate = sessEndDate;
    event.location = sessLocationStr;
    event.calendar = [eventStore defaultCalendarForNewEvents];
    
    NSError *error;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
    
    if (error) {
        NSLog(@"Event Store Error: %@",[error localizedDescription]);
        return NO;
    }else{
        return YES;
    }
    
    //[self createReminder];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showSMS
{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[@"22333"];
    //NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    //[messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (IBAction)takePoll:(id)sender {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        [self showSMS];
    }
    else{
        NSString * myURL = [NSString stringWithFormat:@"http://pollev.com"];
        NSURL *URL = [NSURL URLWithString:myURL];
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
        [self.navigationController pushViewController:webViewController animated:YES];
    }

    
}


@end
