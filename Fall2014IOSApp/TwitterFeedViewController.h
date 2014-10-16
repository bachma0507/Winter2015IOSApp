//
//  TwitterFeedViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/20/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterFeedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
