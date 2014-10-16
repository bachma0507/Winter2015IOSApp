//
//  ReportViewController.m
//  Canada2014IOSApp
//
//  Created by Barry on 3/15/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "ReportViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ReportViewController ()

@end

@implementation ReportViewController

@synthesize commentTextField = _commentTextField;

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
    
    _commentTextField.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.commentTextField = nil;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    [self.commentTextField resignFirstResponder];
    
    if ([self.commentTextField.text isEqualToString:@""]) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        NSURL *fileURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds/Modern/sms_alert_bamboo.caf"]; // see list below
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
        AudioServicesPlaySystemSound(soundID);
        
        NSString *message = @"Please enter a Pic ID.";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil,nil];
        [alertView show];
        
    }
    else{
    //Begin Send email
    NSString *post =[[NSString alloc] initWithFormat:@"message=%@",self.commentTextField.text];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:@"https://speedyreference.com/objectionablereportsubmitted.php"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %ld", (long)[response statusCode]);
    
    if ([response statusCode] >= 200 && [response statusCode] < 300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
    }
    
    //End send email
    
    [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
