//
//  NotesViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"
#import <MessageUI/MessageUI.h>

@class NotesViewController;

@protocol NotesViewControllerDelegate
- (void)NotesViewControllerDidFinish:(NotesViewController *)controller;
@end

@interface NotesViewController : UIViewController <UITextViewDelegate,MFMailComposeViewControllerDelegate>

{
    UITextField * sessionNamelabelText;
    UITextField * sessionIDlabelText;
    
}

@property (weak, nonatomic) id <NotesViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *sessionIDlabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionNamelabel;
@property (strong, nonatomic) IBOutlet UITextView *notesTextField;

@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * location;


@property (strong, nonatomic) IBOutlet UITextField * sessionNamelabelText;
@property (strong, nonatomic) IBOutlet UITextField * sessionIDlabelText;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;


@property (nonatomic, strong) Sessions * mySessions;

- (IBAction)saveNoteButtonPressed:(id)sender;
- (IBAction)showEmail:(id)sender;

@end
