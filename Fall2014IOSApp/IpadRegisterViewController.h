//
//  IpadRegisterViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 10/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IpadRegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailRegisterTextField;


-(IBAction)signUpUserPressed:(id)sender;

@end

