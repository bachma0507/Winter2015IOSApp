//
//  ChatLoginViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 10/10/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatLoginViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (strong, nonatomic) IBOutlet UIButton *createUserButton;


-(IBAction)logInPressed:(id)sender;
- (IBAction)loginButtonTouchHandler:(id)sender;

@end
