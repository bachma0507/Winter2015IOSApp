//
//  SessionsViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/29/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SessionsViewController.h"
#import "EditNoteViewController.h"
#import "SessionNotes.h"
#import "SVWebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NotesViewController.h"
//#import "StackMob.h"
#import "Fall2013IOSAppAppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "SVWebViewController.h"

@interface SessionsViewController () <MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *mySessionnotes;

@end

@implementation SessionsViewController
@synthesize session1Label, session1DateLabel, session1TimeLabel, session1DescTextField, speakerNameLabel, speakers;
@synthesize session1DateLabelText, session1descTextFieldText, session1LabelText, session1TimeLabelText, speakerNameLabelText;
@synthesize sessionName, sessionDate, sessionTime, sessionDesc, name, sessionId, sessionIdLabel, agendaButton, startTime, endTime, locationLabel,location, sessionDay, poll1, pollButton;

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
    
    //NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    //NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    //NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    pollButton.hidden = YES;
    
    //self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //self.title = speakerNameLabelText.text;
    
    session1Label.text = self.sessionName;
    session1DateLabel.text = self.sessionDate;
    session1TimeLabel.text = self.sessionTime;
    session1DescTextField.text = self.sessionDesc;
    speakerNameLabel.text = self.name;
    sessionIdLabel.text = self.sessionId;
    locationLabel.text = self.location;
    
    startTime = self.startTime;
    endTime = self.endTime;
    location = self.location;
    sessionDay = self.sessionDay;
    poll1 = self.poll1;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        [self.pollButton setHidden:YES];
//    }
    
    if ([self.poll1  isEqual: @""]) {
        [self.pollButton setHidden:YES];
    }
    
    
    NSLog(@"Session Id 1 is: %@", self.sessionId);
    NSLog(@"SESSION DATE IS: %@", self.sessionDate);
    
    //session1DescTextField.layer.borderWidth = 2.0f;
    //session1DescTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    // For the border and rounded corners
    [[session1DescTextField layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[session1DescTextField layer] setBorderWidth:2.3];
    [[session1DescTextField layer] setCornerRadius:10];
    [session1DescTextField setClipsToBounds: YES];
    
    // Setup View
    //[self setupView];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && agenda == 'Yes'",self.sessionId]];
    NSLog(@"MY SESSION ID 1 IS: %@",self.sessionId);
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
//    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
//        //[self.refreshControl endRefreshing];
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



//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Fetch Notes
    //[self fetchNotes];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addEditNotes:(id)sender {
    //
    //    if(!self.mySessionnotes || !self.mySessionnotes.count){
    //
    //        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    //
    //        EditNoteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
    //
    //        //     Initialize Navigation Controller
    //        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    //        //
    //        //     Present View Controller
    //        [self.navigationController presentViewController:nc animated:YES completion:nil];
    //    }
    //    else{
    //        [self fetchNotes];
    //        SessionNotes *sessionnotes = [self.mySessionnotes objectAtIndex:0];
    //
    //        // Initialize Edit Note View Controller
    //        EditNoteViewController *vc = [[EditNoteViewController alloc] initWithSessionNotes:sessionnotes];
    //
    //        // Push View Controller onto Navigation Stack
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"notesDetail"]) {
//
//        if(!self.mySessionnotes || !self.mySessionnotes.count){
//
//            UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//
//            EditNoteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
//            EditNoteViewController *destViewController = segue.destinationViewController;
//
//
//            //     Initialize Navigation Controller
//            //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
//            //
//            //     Present View Controller
//            //[self.navigationController presentViewController:nc animated:YES completion:nil];
//        }
//        else{
//
//            SessionNotes *sessionnotes = [self.mySessionnotes objectAtIndex:0];
//
//            UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//
//            EditNoteViewController *vc = [sb instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
//
//
//            // Initialize Edit Note View Controller
//            vc = [[EditNoteViewController alloc] initWithSessionNotes:sessionnotes];
//
//            // Push View Controller onto Navigation Stack
//            //[self.navigationController pushViewController:vc animated:YES];
//        }
//}
//}
- (void)setupView {
    
    // Fetch Notes
    //[self fetchNotes];
}

- (void)fetchNotes {
    // Fetch Notes
    // self.notes = [NSMutableArray arrayWithArray:[Note findAll]];
    //NSString * myString = [NSString stringWithFormat:@"%@", speakers.sessionID];
    //self.mySessionnotes = [NSMutableArray arrayWithArray:[SessionNotes findAllSortedBy:@"title" ascending:YES]];
//NSString * myFilter = [NSString stringWithFormat:@"%@", self.sessionId];
//NSPredicate * myPredicate = [NSPredicate predicateWithFormat:@"title == '%@'", myFilter];
//self.mySessionnotes = [NSMutableArray arrayWithArray:[SessionNotes findAllWithPredicate:myPredicate]];
    //NSLog(@"Session Id is: %@", self.sessionId);
}

- (IBAction)takeSurvey:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", self.sessionId];
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
    
    
    NSLog(@"MY SESSION ID 1 IS: %@",self.sessionId);
    
     NSManagedObjectContext *context = [self managedObjectContext];
    
    if ([self.agendaButton.currentTitle isEqual:@"Add to Schedule"]) {
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Sessnotes" inManagedObjectContext:context];
        
        [newManagedObject setValue:self.sessionId forKey:@"sessionID"];
        [newManagedObject setValue:self.session1Label.text forKey:@"sessionname"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        NSDate *convDate = [dateFormat dateFromString:self.session1DateLabel.text];
        
        
        [newManagedObject setValue:convDate forKey:@"sessiondate"];
        [newManagedObject setValue:self.session1TimeLabel.text forKey:@"sessiontime"];
        [newManagedObject setValue:self.locationLabel.text forKey:@"location"];
//        NSDateFormatter *df = [[NSDateFormatter alloc] init];
//        [df setDateFormat:@"hh:mm a"];
//        NSDate *sessTime = [df dateFromString: self.startTimeStr];
        
        
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        NSDate *convStartTime = [dateFormat dateFromString:self.startTime];
        
        [newManagedObject setValue:convStartTime forKey:@"starttime"];
        [newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
        [newManagedObject setValue:@"Yes" forKey:@"agenda"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
            NSLog(@"You created a new object!");
            [agendaButton setTitle:@"Remove from Schedule" forState:normal];
        
        
        /////
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];
        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@", self.sessionId]];
        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
        self.objects = results2;
        NSLog(@"Results Count is: %lu", (unsigned long)results2.count);
        if (!results2 || !results2.count){//start nested if block
            NSLog(@"No results2");}
        else{
            NSManagedObject *object = [results2 objectAtIndex:0];
            [object setValue:@"Yes" forKey:@"planner"];
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
            
        }
        
        
        NSLog(@"You updated a PLANNER to YES object in Sessions!");
        /////
        

        
    }
    else{//start else block
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Sessnotes" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@ && agenda == 'Yes'",self.sessionId]];
        NSLog(@"MY SESSION ID 1 IS: %@",self.sessionId);
        
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
        
        //////
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Sessions" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];
        
        [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"sessionID == %@", self.sessionId]];
        NSArray *results2 = [self.managedObjectContext executeFetchRequest:fetchRequest2 error:nil];
        
        self.objects = results2;
        NSLog(@"Results Count is: %lu", (unsigned long)results2.count);
        if (!results2 || !results2.count){//start nested if block
            NSLog(@"No results2");}
        else{
            NSManagedObject *object = [results2 objectAtIndex:0];
            [object setValue:NULL forKey:@"planner"];
            
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
            
            NSLog(@"You updated a PLANNER to NULL object in Sessions");
            
        }
        
        
        
        //////

        
        
        }
    
}//end else block



//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"notesDetail"]) {
//        self.sessionName = session1Label.text;
//    
//        NotesViewController *destViewController = segue.destinationViewController;
//        destViewController.title = session1Label.text;
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
            self.sessionName = session1Label.text;
            
                    NotesViewController *destViewController = segue.destinationViewController;
                    destViewController.title = session1Label.text;
                    destViewController.sessionName = self.sessionName;
                    destViewController.sessionId = self.sessionId;
            
                    NSLog(@"Session ID is %@", self.sessionId);
        }
        
        
        
    }
    else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if ([[segue identifier] isEqualToString:@"notesDetail"]) {
            
            self.sessionName = session1Label.text;
            
            NotesViewController *destViewController = segue.destinationViewController;
            destViewController.title = session1Label.text;
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
    
    NSLog(@"SESSION DATE IS: %@", self.sessionDate);
    
    
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
//    NSDate *date = (NSDate*) self.sessionDate;
//    NSString *myDateStr = [dateFormatter stringFromDate:date];
    
    NSString * myDateStr = self.sessionDate;
    
    
//    NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
//    [timeFormatter1 setDateFormat:@"hh:mm a"];
//    NSDate *time1 = (NSDate*) self.startTime;
//    NSString *myStartTimeStr = [timeFormatter1 stringFromDate:time1];
    
    NSString *myStartTimeStr = self.startTime;
    
//    NSDateFormatter *timeFormatter2 = [[NSDateFormatter alloc] init];
//    [timeFormatter2 setDateFormat:@"hh:mm a"];
//    NSDate *time2 = (NSDate*) self.endTime;
//    NSString *myEndTimeStr = [timeFormatter2 stringFromDate:time2];
    
    NSString *myEndTimeStr = self.endTime;
    
    
    NSLog(@"myDateStr is: %@", myDateStr);
    NSLog(@"myStartTimeStr is: %@", myStartTimeStr);
    NSLog(@"myEndTimeStr is: %@", myEndTimeStr);
    
    NSString *sessDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr,myStartTimeStr];
    NSString *sessEndDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr, myEndTimeStr];
    NSString *sessNameStr = [[NSString alloc]initWithFormat:@"%@", self.sessionName];
    NSString *sessLocationStr = [[NSString alloc]initWithFormat:@"%@", self.location];
    
    NSLog(@"sessDateStr is: %@", sessDateStr);
    NSLog(@"sessEndDateStr is: %@", sessEndDateStr);
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy hh:mm a"];
    //[df setDateStyle:NSDateFormatterMediumStyle];
    NSDate *sessDate = [df dateFromString: sessDateStr];
    NSLog(@"sessDate is: %@", sessDate);
    
    NSDateFormatter *dfEnd = [[NSDateFormatter alloc] init];
    [dfEnd setDateFormat:@"MMM dd yyyy hh:mm a"];
    NSDate *sessEndDate = [df dateFromString: sessEndDateStr];
    NSLog(@"sessEndDate is: %@", sessEndDate);
    
    
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
    
    
    
//    NSString *myDateStr = [[NSString alloc]initWithFormat:@"%@",self.sessionDate];
//    NSString *myStartTimeStr = [[NSString alloc]initWithFormat:@"%@",self.startTime];
//    NSString *myEndTimeStr = [[NSString alloc]initWithFormat:@"%@",self.endTime];
//    
//    NSLog(@"myDateStr is: %@", myDateStr);
//    NSLog(@"myStartTimeStr is: %@", myStartTimeStr);
//    
//    //NSLog(@"start time is %@",myStartTimeStr);
//    NSLog(@"myEndTimeStr is %@",myEndTimeStr);
//    
//    NSString *sessDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr,myStartTimeStr];
//    NSString *sessEndDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr, myEndTimeStr];
//    NSString *sessNameStr = [[NSString alloc]initWithFormat:@"%@", self.sessionName];
//    NSString *sessLocationStr = [[NSString alloc]initWithFormat:@"%@", self.location];
//    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MMM dd yyyy hh:mm a"];
//    NSDate *sessDate = [df dateFromString: sessDateStr];
//    NSLog(@"sessDate is: %@", sessDate);
//    
//    NSDateFormatter *dfEnd = [[NSDateFormatter alloc] init];
//    [dfEnd setDateFormat:@"MMM dd yyyy hh:mm a"];
//    NSDate *sessEndDate = [df dateFromString: sessEndDateStr];
//    NSLog(@"sessEndDate is: %@", sessEndDate);
//    
//    
//    
//    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
//    event.title = sessNameStr;
//    event.startDate = sessDate;
//    //event.endDate = [event.startDate dateByAddingTimeInterval:3600];
//    event.endDate = sessEndDate;
//    event.location = sessLocationStr;
//    event.calendar = [eventStore defaultCalendarForNewEvents];
//    
//    NSError *error;
//    [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
//    
//    if (error) {
//        NSLog(@"Event Store Error: %@",[error localizedDescription]);
//        return NO;
//    }else{
//        return YES;
//    }
//    
//    //[self createReminder];
}

//-(void)createReminder
//{
//    EKEventStore *eventStore = [[EKEventStore alloc]init];
//    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
//        
//        if (!granted)
//        {
//            NSString *message = @"Cannot set reminder!";
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Warning"
//                                                               message:message
//                                                              delegate:self
//                                                     cancelButtonTitle:@"Ok"
//                                                     otherButtonTitles:nil,nil];
//            //Show an alert message!
//            //UIKit needs every change to be done in the main queue
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [alertView show];
//            }
//                           );
//            
//            //Access granted------------------
//        }
//    }];
//
//
//
//    EKReminder *reminder = [EKReminder
//                            reminderWithEventStore:eventStore];
//    NSString *sessNameStr = [[NSString alloc]initWithFormat:@"%@", self.sessionName];
//    
//    reminder.title = sessNameStr;
//    
//    reminder.calendar = [eventStore defaultCalendarForNewReminders];
//    
//    NSString *myDateStr = [[NSString alloc]initWithFormat:@"%@",self.sessionDate];
//    NSString *myStartTimeStr = [[NSString alloc]initWithFormat:@"%@",self.startTime];
//    NSString *sessDateStr = [[NSString alloc]initWithFormat:@"%@ %@",myDateStr,myStartTimeStr];
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"MMM dd yyyy hh:mm a"];
//    NSDate *sessDate = [df dateFromString: sessDateStr];
//    
//    NSDate *date = sessDate;
//    
//    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date];
//    
//    [reminder addAlarm:alarm];
//    
//    NSError *error = nil;
//    
//    [eventStore saveReminder:reminder commit:YES error:&error];
//    
//    if (error)
//        NSLog(@"error = %@", error);
//    
//}

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
