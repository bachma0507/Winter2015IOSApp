//
//  MoreViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "MoreViewController.h"


@interface MoreViewController ()

@end

@implementation MoreViewController

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
    
    
//    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showEmail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
        NSString *deviceID = [[NSString alloc] initWithFormat:@"%@",id];
        NSString *newDeviceID = [deviceID substringWithRange:NSMakeRange(30, [deviceID length]-30)];
        
        NSLog(@"Untruncated Device ID is: %@", deviceID);
        NSLog(@"Truncated Device ID is: %@", newDeviceID);
        
        
        UIDevice *currentDevice = [UIDevice currentDevice];
        NSString *model = [currentDevice model];
        NSString *systemVersion = [currentDevice systemVersion];
        
        NSArray *languageArray = [NSLocale preferredLanguages];
        NSString *language = [languageArray objectAtIndex:0];
        NSLocale *locale = [NSLocale currentLocale];
        NSString *country = [locale localeIdentifier];
        
        NSString *appVersion = [[NSBundle mainBundle]
                                objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];

        NSString *deviceSpecs =
        [NSString stringWithFormat:@"Model: %@ \n System Version: %@ \n Language: %@ \n Country: %@ \n App Version: %@",
         model, systemVersion, language, country, appVersion];
        NSLog(@"Device Specs --> %@",deviceSpecs);
        
//        NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter issue:\n \n My Device Specs: \n %@",deviceSpecs];
//        NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"Email BICSI Tech Support"];
        
        NSString * emailNoteBody = [[NSString alloc] initWithFormat:@"Enter your comments"];
        NSString * emailNoteSubject = [[NSString alloc] initWithFormat:@"My Comments: 2014 Fall Conference"];

        
        // Email Subject
        NSString *emailTitle = emailNoteSubject;
        // Email Content
        NSString *messageBody = emailNoteBody;
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"support@bicsi.org"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
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
