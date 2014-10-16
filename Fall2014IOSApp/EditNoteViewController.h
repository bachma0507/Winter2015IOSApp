//
//  EditNoteViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/29/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"
@class SessionNotes;

@interface EditNoteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *notesTextField;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@property (nonatomic, strong) NSString * sessionId;

@property (strong, nonatomic) IBOutlet UILabel *sessionIdLabel;
@property (strong, nonatomic) IBOutlet UITextField *sessionIdTextField;
@property (nonatomic, strong) Speakers * speakers;

- (id)initWithSessionNotes:(SessionNotes *)sessionnotes;

@end
