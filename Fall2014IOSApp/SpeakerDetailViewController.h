//
//  SpeakerDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"
#import "SessionsViewController.h"
#import "Session2ViewController.h"

@interface SpeakerDetailViewController : UIViewController
{
    SessionsViewController * sessionsViewController;
}

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * company;
@property (nonatomic, strong) NSString * bio;
@property (nonatomic, strong) NSString * poll1;
@property (nonatomic, strong) NSString * sessionDesc;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionDate;
@property (nonatomic, strong) NSString * sessionTime;
@property (nonatomic, strong) NSString * session2Desc;
@property (nonatomic, strong) NSString * session2Name;
@property (nonatomic, strong) NSString * session2Date;
@property (nonatomic, strong) NSString * session2Time;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * sessionId2;
@property (nonatomic, strong) NSString * startTimeStr;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * sess2StartTime;
@property (nonatomic, strong) NSString * sess2EndTime;
@property (nonatomic, strong) NSString * location2;
@property (nonatomic, strong) NSString * poll2;


@property (strong, nonatomic) IBOutlet UILabel *speakerName;
//@property (strong, nonatomic) IBOutlet UILabel *speakerLastName;
@property (strong, nonatomic) IBOutlet UILabel *speakerCompany;
@property (strong, nonatomic) IBOutlet UILabel *speakerWebsite;
@property (strong, nonatomic) IBOutlet UITextView *speakerBioTextView;
@property (strong, nonatomic) IBOutlet UIImageView *speakerPic;
@property (strong, nonatomic) IBOutlet UILabel *session1label;
@property (strong, nonatomic) IBOutlet UILabel *session1DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *session1TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *session2label;
@property (strong, nonatomic) IBOutlet UILabel *session2DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *session2TimeLabel;


@property (nonatomic, strong) Speakers * speakers;

@property (strong, nonatomic) NSArray *objects;

//- (IBAction)buttonPressed:(id)sender;

@end
