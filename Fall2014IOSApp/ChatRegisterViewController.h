//
//  ChatRegisterViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 10/10/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailRegisterTextField;
@property (strong, nonatomic) IBOutlet UITextField *userFullNameTextField;
- (IBAction)ForgotButtonPressed:(id)sender;


-(IBAction)signUpUserPressed:(id)sender;


@end
