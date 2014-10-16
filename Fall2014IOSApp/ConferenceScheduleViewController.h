//
//  ConferenceScheduleViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConferenceScheduleViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@end
