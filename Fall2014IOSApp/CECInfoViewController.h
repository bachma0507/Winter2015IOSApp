//
//  CECInfoViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Html.h"

@class CECInfoViewController;

@protocol CECInfoViewControllerDelegate

@end

@interface CECInfoViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) id <CECInfoViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * htmlArray;
//@property (nonatomic, strong) NSMutableArray * results;
//@property BOOL isFiltered;

@property (strong, nonatomic) NSArray *objects;



@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
