//
//  SessionsViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/29/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"
#import "NotesViewController.h"
#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "SurveyViewController.h"

@interface SessionsViewController : UIViewController <NotesViewControllerDelegate, SurveyViewControllerDelegate,UIPopoverControllerDelegate>

{
    UITextField * session1LabelText;
    UITextField * session1DateLabelText;
    UITextField * session1TimeLabelText;
    UITextField * session1descTextFieldText;
    UITextField * speakerNameLabelText;
    
    
}
@property (strong, nonatomic) UIPopoverController *NotesPopoverController;
@property (strong, nonatomic) UIPopoverController *SurveyPopoverController;
@property (strong, nonatomic) IBOutlet UILabel *session1Label;
@property (strong, nonatomic) IBOutlet UILabel *session1DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *session1TimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UITextView *session1DescTextField;
@property (strong, nonatomic) IBOutlet UILabel *speakerNameLabel;
@property (nonatomic, strong) NSString * sessionDesc;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionDate;
@property (nonatomic, strong) NSString * sessionTime;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * sessionDay;
@property (nonatomic, strong) NSString * poll1;
@property (strong, nonatomic) IBOutlet UILabel *sessionIdLabel;


@property (strong, nonatomic) IBOutlet UITextField * session1LabelText;
@property (strong, nonatomic) IBOutlet UITextField * session1DateLabelText;
@property (strong, nonatomic) IBOutlet UITextField * session1TimeLabelText;
@property (strong, nonatomic) IBOutlet UITextField * session1descTextFieldText;
@property (strong, nonatomic) IBOutlet UITextField * speakerNameLabelText;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UIButton *agendaButton;
@property (strong, nonatomic) IBOutlet UIButton *pollButton;

@property (nonatomic, strong) Speakers * speakers;

//EventKit stuff
- (IBAction)AddEvent:(id)sender;
- (BOOL)createEvent:(EKEventStore*)eventStore;

- (IBAction)addEditNotes:(id)sender;
- (IBAction)takeSurvey:(id)sender;
- (IBAction)agendaButtonPressed:(id)sender;
- (IBAction)takePoll:(id)sender;
@end
