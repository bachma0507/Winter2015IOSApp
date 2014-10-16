//
//  IpadLoginViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 10/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IpadLoginViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *userTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;


-(IBAction)logInPressed:(id)sender;
- (IBAction)loginButtonTouchHandler:(id)sender;

@end

