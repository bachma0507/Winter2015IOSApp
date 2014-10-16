//
//  iPadReportViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 3/17/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadReportViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *commentTextField;
- (IBAction)buttonPressed:(id)sender;


@end
