//
//  ExhibitorNotesViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ExhibitorNotesViewController : UIViewController<UITextViewDelegate,MFMailComposeViewControllerDelegate>

{
    UITextField * exhibitorNamelabelText;
    UITextField * boothNumberlabelText;
    
}
@property (strong, nonatomic) IBOutlet UILabel *boothNumberlabel;
@property (strong, nonatomic) IBOutlet UILabel *exhibitorNamelabel;
@property (strong, nonatomic) IBOutlet UITextView *notesTextField;

@property (nonatomic, strong) NSString * exhibitorName;
@property (nonatomic, strong) NSString * boothNumber;

@property (strong, nonatomic) IBOutlet UITextField * exhibitorNamelabelText;
@property (strong, nonatomic) IBOutlet UITextField * boothNumberlabelText;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)saveNoteButtonPressed:(id)sender;
- (IBAction)showEmail:(id)sender;

@end
