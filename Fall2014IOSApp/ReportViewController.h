//
//  ReportViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 3/15/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *commentTextField;
- (IBAction)buttonPressed:(id)sender;

@end
