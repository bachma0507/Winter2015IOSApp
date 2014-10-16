//
//  Fall2013IOSAppViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fall2013IOSAppViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
}


@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
