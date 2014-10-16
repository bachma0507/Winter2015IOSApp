//
//  InfoDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/2/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoItems.h"

@interface InfoDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *back;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, strong) infoItems *infoitems;

- (IBAction)backButtonPressed:(id)sender;

@end
