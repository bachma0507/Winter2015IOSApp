//
//  SurveysViewController.h
//  Winter2015IOSApp
//
//  Created by Barry on 12/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SurveysViewController;

@protocol SurveysViewControllerDelegate

@end

@interface SurveysViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) id <SurveysViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
