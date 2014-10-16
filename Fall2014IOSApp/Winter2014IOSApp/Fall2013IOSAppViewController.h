//
//  Fall2013IOSAppViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fall2013IOSAppViewController : UIViewController <UIWebViewDelegate>
{
    UIWebView *webView;
    UIButton *back;
    NSTimer *timer;
}




@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)backButtonPressed:(id)sender;

@end
