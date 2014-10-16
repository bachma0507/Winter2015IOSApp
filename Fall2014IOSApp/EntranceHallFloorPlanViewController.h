//
//  EntranceHallFloorPlanViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 3/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntranceHallFloorPlanViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
