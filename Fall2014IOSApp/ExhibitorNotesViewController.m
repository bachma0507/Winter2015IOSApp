//
//  ExhibitorNotesViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitorNotesViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ExhibitorNotesViewController ()

@end

@implementation ExhibitorNotesViewController
@synthesize exhibitorName, exhibitorNamelabel, exhibitorNamelabelText, statusLabel, notesTextField, boothNumber, boothNumberlabel, boothNumberlabelText;

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
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorites" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"boothnumber == %@",self.boothNumber]];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
    //[self.refreshControl endRefreshing];
    self.objects = results;
    if (!results || !results.count){
        self.notesTextField.delegate = self;
    }
    else{
        NSManagedObject *object = [results objectAtIndex:0];
        notesTextField.text = [object valueForKey:@"notes"];
    }
    //[self.tableView reloadData];
    
    //    } onFailure:^(NSError *error) {
    //
    //        //[self.refreshControl endRefreshing];
    //        NSLog(@"An error %@, %@", error, [error userInfo]);
    //    }];
    
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    
    //self.title = sessionNamelabel.text;
    
    exhibitorNamelabel.text = self.exhibitorName;
    boothNumberlabel.text = self.boothNumber;
    
    [[notesTextField layer] setBorderColor:[[UIColor colorWithRed:48/256.0 green:134/256.0 blue:174/256.0 alpha:1.0] CGColor]];
    [[notesTextField layer] setBorderWidth:2.3];
    [[notesTextField layer] setCornerRadius:10];
    [notesTextField setClipsToBounds: YES];
}

//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)saveNoteButtonPressed:(id)sender {
    
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
    NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorites" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"boothnumber == %@",self.boothNumber]];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
    self.objects = results;
    if (!results || !results.count)
    {//if block begin
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Favorites" inManagedObjectContext:context];
        
        [newManagedObject setValue:self.notesTextField.text forKey:@"notes"];
        [newManagedObject setValue:self.boothNumberlabel.text forKey:@"boothnumber"];
        [newManagedObject setValue:self.exhibitorNamelabel.text forKey:@"exhibitorname"];
        [newManagedObject setValue:newDeviceID forKey:@"deviceowner"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You created a new object!");
        NSString *status = [[NSString alloc] initWithFormat:@"Notes saved!"];
        self.statusLabel.text = status;
        self.statusLabel.textColor = [UIColor greenColor];
        
        
    }//if block end
    
    
    else{//else block begin
        
        NSManagedObject *object = [results objectAtIndex:0];
        [object setValue:self.notesTextField.text forKey:@"notes"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSLog(@"You updated the object!");
        NSString *status = [[NSString alloc] initWithFormat:@"Notes saved!"];
        self.statusLabel.text = status;
        self.statusLabel.textColor = [UIColor greenColor];
        
        
        
    }//else block ends
    
}

- (IBAction)showEmail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        
        NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"%@",notesTextField.text];
        NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"Notes: %@",exhibitorNamelabel.text];
        
        // Email Subject
        NSString *emailTitle = emailNoteSubject;
        // Email Content
        NSString *messageBody = emailNoteBody;
        // To address
        //NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        //[mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
