//
//  ExhibitorWebViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/31/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exhibitors.h"

@interface ExhibitorWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) exhibitors * myExhibitors;
@property (nonatomic, strong) NSString * coId;
@property (nonatomic, strong) NSString * boothId;
@property (nonatomic, strong) NSString * eventId;

@property  (nonatomic, strong) IBOutlet UIWebView * myWebView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
