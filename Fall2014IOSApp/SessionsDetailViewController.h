//
//  SessionsDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/12/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"
#import "NotesViewController.h"
#import <CoreData/CoreData.h>
#import <EventKit/EventKit.h>
#import "SurveyViewController.h"

@interface SessionsDetailViewController : UIViewController <NotesViewControllerDelegate, SurveyViewControllerDelegate,UIPopoverControllerDelegate>


//{
//    UITextField * sessionNameLabelText;
//    UITextField * sessionDateLabelText;
//    UITextField * sessionTimeLabelText;
//    UITextField * sessionDescTextFieldText;
//    UITextField * speaker1NameLabelText;
//    UITextField * speaker2NameLabelText;
//    UITextField * speaker3NameLabelText;
//    UITextField * speaker4NameLabelText;
//    UITextField * speaker5NameLabelText;
//    UITextField * speaker6NameLabelText;
//
//
//}
@property (strong, nonatomic) UIPopoverController *NotesPopoverController;
@property (strong, nonatomic) UIPopoverController *SurveyPopoverController;
@property (strong, nonatomic) IBOutlet UILabel *sessionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionTimeLabel;
@property (strong, nonatomic) IBOutlet UITextView *sessionDescTextField;
@property (strong, nonatomic) IBOutlet UILabel *speaker1NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *speaker2NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *speaker3NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *speaker4NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *speaker5NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *speaker6NameLabel;
//@property (nonatomic, strong) NSString * sessionDesc;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
//@property (strong, nonatomic) IBOutlet UILabel *itscecsLabel;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionDate;
//@property (nonatomic, strong) NSString * sessionTime;
//@property (nonatomic, strong) NSString * name1;
//@property (nonatomic, strong) NSString * name2;
//@property (nonatomic, strong) NSString * name3;
//@property (nonatomic, strong) NSString * name4;
//@property (nonatomic, strong) NSString * name5;
//@property (nonatomic, strong) NSString * name6;
@property (nonatomic, strong) NSString * sessionId;
@property (strong, nonatomic) IBOutlet UILabel *sessionIdLabel;
@property (nonatomic, strong) NSString * startTimeStr;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * sessionDay;



//@property (strong, nonatomic) IBOutlet UITextField * sessionNameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * sessionDateLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * sessionTimeLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * sessionDescTextFieldText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker1NameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker2NameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker3NameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker4NameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker5NameLabelText;
//@property (strong, nonatomic) IBOutlet UITextField * speaker6NameLabelText;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UIButton *agendaButton;
@property (strong, nonatomic) IBOutlet UIButton *pollButton;

- (BOOL)createEvent:(EKEventStore*)eventStore;

@property (nonatomic, strong) Sessions * mySessions;
- (IBAction)agendaButtonPressed:(id)sender;

- (IBAction)takeSurvey:(id)sender;
- (IBAction)AddEvent:(id)sender;
- (IBAction)takePoll:(id)sender;

@end
