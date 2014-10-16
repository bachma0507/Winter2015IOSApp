//
//  SpeakerDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SpeakerDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Fall2013IOSAppAppDelegate.h"





@interface SpeakerDetailViewController ()


@end

@implementation SpeakerDetailViewController

@synthesize name;
@synthesize company;
@synthesize bio;
@synthesize speakerName;
@synthesize speakerCompany;
@synthesize speakerBioTextView;
@synthesize speakers;
@synthesize poll1;
@synthesize speakerWebsite;
@synthesize speakerPic, session1DateLabel, session1label, session1TimeLabel, sessionDesc, sessionName, sessionDate, sessionTime, sessionId;
@synthesize session2Date;
@synthesize session2DateLabel;
@synthesize session2Desc;
@synthesize session2label;
@synthesize session2Name;
@synthesize session2Time;
@synthesize session2TimeLabel;
@synthesize sessionId2;
@synthesize objects;
@synthesize startTimeStr;
@synthesize endTime;
@synthesize location;
@synthesize sess2EndTime;
@synthesize sess2StartTime;
@synthesize location2;
@synthesize poll2;


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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    session2DateLabel.hidden = YES;
    session2label.hidden = YES;
    session2TimeLabel.hidden = YES;
    
    NSString * bioText = [[NSString alloc] initWithFormat:@"%@ %@ represents %@, %@ %@, %@", speakers.speakerName, speakers.speakerLastName, speakers.speakerCompany, speakers.speakerCity, speakers.speakerState, speakers.speakerCountry ];
    
    
    speakerBioTextView.text = bioText;
    
    NSString * firstName = [[NSString alloc] initWithFormat:@"%@", speakers.speakerName];
    NSString * lastName = [[NSString alloc] initWithFormat:@"%@", speakers.speakerLastName];
    NSString * fullName = [[NSString alloc] initWithFormat:@"%@ %@", firstName, lastName];
    
    self.title = fullName;
    
    //set our labels
    speakerName.text = fullName;
    speakerName.textColor = [UIColor brownColor];
    speakerCompany.text = speakers.speakerCompany;
    //speakerBioTextView.text = speakers.speakerBio;
    session1label.text = speakers.session1;
    
    NSString * sessDate = speakers.session1Date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSDate *sessionD = [dateFormat dateFromString:sessDate];
    
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    sessDate = [dateFormat stringFromDate:sessionD];
    
    
    session1DateLabel.text = sessDate;
    
    NSString * timePeriod = [[NSString alloc] initWithFormat:@"%@ - %@", speakers.startTime, speakers.endTime];
    
    
    session1TimeLabel.text = timePeriod;
    sessionDesc = speakers.session1Desc;
    
//    session2label.text = speakers.session2;
//    session2DateLabel.text = speakers.session2Date;
//    session2TimeLabel.text = speakers.session2Time;
//    session2Desc = speakers.session2Desc;
    
    sessionId = speakers.sessionID;
    //sessionId2 = speakers.sessionID2;
    
    startTimeStr = speakers.startTime;
    endTime = speakers.endTime;
    location = speakers.location;
    
//    sess2StartTime = speakers.sess2StartTime;
//    sess2EndTime = speakers.sess2EndTime;
//    location2 = speakers.location2;
//    poll1 = speakers.speakerWebsite;
//    speakerPic = speakers.speakerPic;
//    
//    NSLog(@"Poll1 is: %@", speakers.speakerWebsite);
//    NSLog(@"Poll2 is: %@", speakers.speakerPic);

    
    [[speakerBioTextView layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[speakerBioTextView layer] setBorderWidth:2.3];
    [[speakerBioTextView layer] setCornerRadius:10];
    [speakerBioTextView setClipsToBounds: YES];
    
    NSLog(@"Session Id 2 is: %@", self.sessionId2);
    NSLog(@"Session Id 1 is: %@", self.sessionId);
    
    
    NSString * myPic = [NSString stringWithFormat:@"speakerpic.png"];
    
    UIImage* myImage = [UIImage imageNamed:myPic];
    
    [speakerPic setImage:myImage];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"sessionInfo"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.sessionName = session1label.text;
        self.name = speakerName.text;
        self.sessionDate = session1DateLabel.text;
        self.sessionTime = session1TimeLabel.text;
        self.sessionDesc = sessionDesc;
        self.startTimeStr = startTimeStr;
        self.endTime = endTime;
        self.location = location;
        self.sess2StartTime = sess2StartTime;
        self.sess2EndTime = sess2EndTime;
        self.location2 = location2;
        self.poll1 = poll1;
        self.poll2 = poll2;
        
        
        self.sessionId = sessionId;
        SessionsViewController *destViewController = segue.destinationViewController;
        destViewController.sessionName = self.sessionName;
        destViewController.sessionName = self.sessionName;
        destViewController.name = self.name;
        destViewController.title = session1label.text;
        destViewController.sessionDate = self.sessionDate;
        destViewController.sessionTime = self.sessionTime;
        destViewController.sessionDesc = self.sessionDesc;
        destViewController.sessionId = self.sessionId;
        destViewController.startTime = self.startTimeStr;
        destViewController.endTime = self.endTime;
        destViewController.location = self.location;
        destViewController.poll1 = self.poll1;
//        destViewController.session1LabelText.text = @"Hello";
        NSLog(@"SessionID 1 is: %@", self.sessionId);
    }
    if ([segue.identifier isEqualToString:@"session2Info"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.session2Name = session2label.text;
        self.name = speakerName.text;
                
        self.session2Date = session2DateLabel.text;
        self.session2Time = session2TimeLabel.text;
        self.session2Desc = session2Desc;
        
        self.sessionId2 = sessionId2;
        Session2ViewController *destViewController = segue.destinationViewController;
        destViewController.session2Name = self.session2Name;
        //destViewController.sessionName = self.sessionName;
        destViewController.name = self.name;
        destViewController.title = session2label.text;
        destViewController.session2Date = self.session2Date;
        destViewController.session2Time = self.session2Time;
        destViewController.session2Desc = self.session2Desc;
        destViewController.sessionId2 = self.sessionId2;
        destViewController.sess2StartTime = self.sess2StartTime;
        destViewController.sess2EndTime = self.sess2EndTime;
        destViewController.location2 = self.location2;
        destViewController.poll2 = self.poll2;
        //        destViewController.session1LabelText.text = @"Hello";
        NSLog(@"SessionID 2 is: %@", self.sessionId2);
    }

}



@end
