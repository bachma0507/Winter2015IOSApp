//
//  SurveyViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 6/3/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sessions.h"

@class SurveyViewController;

@protocol SurveyViewControllerDelegate
- (void)SurveyViewControllerDidFinish:(SurveyViewController *)controller;
@end

@interface SurveyViewController : UIViewController <UIWebViewDelegate>

//{
//    UITextField * sessionNamelabelText;
//    UITextField * sessionIDlabelText;
//
//}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

//@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionId;

@property (weak, nonatomic) id <SurveyViewControllerDelegate> delegate;

@property (nonatomic, strong) Sessions * mySessions;

@end
