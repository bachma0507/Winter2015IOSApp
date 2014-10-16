//
//  SocialDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/8/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "socialItems.h"

@interface SocialDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, strong) socialItems *socialitems;

@end
