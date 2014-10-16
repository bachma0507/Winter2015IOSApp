//
//  LocateOnMapViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 11/3/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exhibitors.h"

@interface LocateOnMapViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) exhibitors * myExhibitors;
@property (nonatomic, strong) NSString * boothLabel;
@property (nonatomic, strong) NSString * name;


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
