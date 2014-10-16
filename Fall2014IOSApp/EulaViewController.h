//
//  EulaViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 3/26/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EulaViewController : UIViewController<UIWebViewDelegate>
- (IBAction)okPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
