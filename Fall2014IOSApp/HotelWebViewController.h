//
//  HotelWebViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 2/13/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotelWebViewController;

@protocol HotelWebViewControllerDelegate

@end

@interface HotelWebViewController : UIViewController<UIWebViewDelegate>


@property (weak, nonatomic) id <HotelWebViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
