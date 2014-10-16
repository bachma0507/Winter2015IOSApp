//
//  ExhibitHallFloorPlanViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitHallFloorPlanViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

//- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;

//- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;


@end
