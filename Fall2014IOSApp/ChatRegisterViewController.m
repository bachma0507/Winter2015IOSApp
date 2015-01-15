//
//  ChatRegisterViewController.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/10/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "ChatRegisterViewController.h"

#import "AppConstant.h"

#import <Parse/Parse.h>

#import <CommonCrypto/CommonDigest.h>
#import "NSString+MD5.h"
#import "SVWebViewController.h"

@interface ChatRegisterViewController ()

@end

@implementation ChatRegisterViewController

@synthesize userRegisterTextField = _userRegisterTextField, passwordRegisterTextField = _passwordRegisterTextField, emailRegisterTextField = _emailRegisterTextField, userFullNameTextField = _userFullNameTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userRegisterTextField = nil;
    self.passwordRegisterTextField = nil;
    self.emailRegisterTextField = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



#pragma mark IB Actions

////Sign Up Button pressed
- (IBAction)ForgotButtonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.bicsi.org/m/forgot.aspx"];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
    
    
}

-(IBAction)signUpUserPressed:(id)sender
{
    ////////////////BICSI STUFF
    NSInteger success = 0;
    @try {
        
        
        if([self.userRegisterTextField.text isEqualToString:@""] || [self.passwordRegisterTextField.text isEqualToString:@""] ) {
            
            [self alertStatus:@"Please enter Username and Password" :@"Sign in Failed!" :0];
            
        } else {
            
            
            NSString *PW = [[NSString alloc] initWithFormat:@"%@", self.passwordRegisterTextField.text];
            NSString *hashPW = [PW MD5];
            
            
            
            NSString *post =[[NSString alloc] initWithFormat:@"Name=%@&PW=%@", self.userRegisterTextField.text, hashPW];
            
            NSLog(@"PostData: %@",post);
            
            
            NSString * webURL = [[NSString alloc] initWithFormat:@"https://webservice.bicsi.org/json/reply/MobAuth?Name=%@&PW=%@", self.userRegisterTextField.text, hashPW];
            
            
            NSURL *url=[NSURL URLWithString:webURL];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed - You must be a BICSI Member to sign in" :@"Sign in Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
    
    ////////////////////////////PARSE STUFF
    PFUser *user = [PFUser user];
    user.username = self.userRegisterTextField.text;
    user.password = self.passwordRegisterTextField.text;
    user.email = self.emailRegisterTextField.text;
    user[PF_USER_EMAILCOPY] = self.emailRegisterTextField.text;
    user[PF_USER_FULLNAME] = self.userFullNameTextField.text;
    user[PF_USER_FULLNAME_LOWER] = [self.userFullNameTextField.text lowercaseString];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was succesful, go to the wall
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
    }
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
}



@end
