//
//  Session2ViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"
#import "NotesViewController.h"
#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "SurveyViewController.h"

@interface Session2ViewController : UIViewController <NotesViewControllerDelegate, SurveyViewControllerDelegate,UIPopoverControllerDelegate>

{
    UITextField * session2LabelText;
    UITextField * session2DateLabelText;
    UITextField * session2TimeLabelText;
    UITextField * session2descTextFieldText;
    UITextField * speakerNameLabelText;
    
    
}

@property (strong, nonatomic) UIPopoverController *NotesPopoverController;
@property (strong, nonatomic) UIPopoverController *SurveyPopoverController;
@property (strong, nonatomic) IBOutlet UILabel *session2Label;
@property (strong, nonatomic) IBOutlet UILabel *session2DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *session2TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UITextView *session2DescTextField;
@property (strong, nonatomic) IBOutlet UILabel *speakerNameLabel;
@property (nonatomic, strong) NSString * session2Desc;
@property (nonatomic, strong) NSString * session2Name;
@property (nonatomic, strong) NSString * session2Date;
@property (nonatomic, strong) NSString * session2Time;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * sessionId2;
@property (nonatomic, strong) NSString * sess2StartTime;
@property (nonatomic, strong) NSString * sess2EndTime;
@property (nonatomic, strong) NSString * location2;
@property (nonatomic, strong) NSString * poll2;
@property (strong, nonatomic) IBOutlet UILabel *sessionIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionId2Label;


@property (strong, nonatomic) IBOutlet UITextField * session2LabelText;
@property (strong, nonatomic) IBOutlet UITextField * session2DateLabelText;
@property (strong, nonatomic) IBOutlet UITextField * session2TimeLabelText;
@property (strong, nonatomic) IBOutlet UITextField * session2descTextFieldText;
@property (strong, nonatomic) IBOutlet UITextField * speakerNameLabelText;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UIButton *agendaButton;
@property (strong, nonatomic) IBOutlet UIButton *pollButton;

@property (nonatomic, strong) Speakers * speakers;

- (BOOL)createEvent:(EKEventStore*)eventStore;

//- (IBAction)addEditNotes:(id)sender;
- (IBAction)takeSurvey:(id)sender;
- (IBAction)agendaButtonPressed:(id)sender;
- (IBAction)AddEvent:(id)sender;
- (IBAction)takePoll:(id)sender;


@end
