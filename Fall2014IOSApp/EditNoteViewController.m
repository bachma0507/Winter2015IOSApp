//
//  EditNoteViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/29/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "EditNoteViewController.h"
#import "SessionNotes.h"

@interface EditNoteViewController ()

@property (nonatomic, strong) SessionNotes *sessionnotes;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation EditNoteViewController
@synthesize notesTextField;
@synthesize speakers;
@synthesize titleTextField;
@synthesize sessionId;
@synthesize sessionIdTextField;
@synthesize sessionIdLabel;

#pragma mark -
#pragma mark Initialization
- (id)initWithSessionNotes:(SessionNotes *)sessionnotes {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    EditNoteViewController* vc = [sb instantiateViewControllerWithIdentifier:@"EditNoteViewController"];
    vc = [[EditNoteViewController alloc]init];
    self = vc;

    
    if (self) {
        // Set Note
        self.sessionnotes = sessionnotes;
        
        // Set Flag
        self.isEditing = YES;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Set Flag
        self.isEditing = NO;
        //self.isEditing = YES;
    }
    
    return self;
}


#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sessionIdLabel.text = self.sessionId;
    //self.sessionIdTextField.text = self.sessionId;
    
    // Setup View
    [self setupView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Actions
- (void)cancel:(id)sender {
    // Dismiss View Controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save:(id)sender {
    if (!self.sessionnotes) {
        // Create Note
        self.sessionnotes = [SessionNotes createEntity];
        
        
        // Configure Note
        //[self.sessionnotes setDate:[NSDate date]];
    }
    
    // Configure Note
    
    //self.sessionIdTextField.text = self.sessionId;
    [self.sessionnotes setTitle:[self.titleTextField text]];
    
    [self.sessionnotes setNotes:[self.notesTextField text]];
    //[self.note setKeywords:[self.keywordsField text]];
    //[self.note setBody:[self.bodyView text]];
    
    // Save Managed Object Context
    [[NSManagedObjectContext defaultContext] saveNestedContexts];
    
    if (self.isEditing) {
        // Pop View Controller from Navigation Stack
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        // Dismiss View Controller
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark View Methods
- (void)setupView {
    // Create Cancel Button
    if (!self.sessionnotes) {
//        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
//        self.navigationItem.leftBarButtonItem = cancelButton;
        
    }
    
    // Create Save Button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    if (self.sessionnotes) {
        // Populate Form Fields
        
        [self.notesTextField setText:[self.sessionnotes notes]];
        [self.titleTextField setText:[self.sessionnotes title]];
        //[self.keywordsField setText:[self.note keywords]];
        //[self.bodyView setText:[self.note body]];
    }
}

@end
