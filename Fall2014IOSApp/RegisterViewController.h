//
//  RegisterViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 10/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailRegisterTextField;


-(IBAction)signUpUserPressed:(id)sender;

@end

