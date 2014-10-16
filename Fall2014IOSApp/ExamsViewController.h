//
//  ExamsViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExamsViewController;

@protocol ExamsViewControllerDelegate

@end


@interface ExamsViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) id <ExamsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
