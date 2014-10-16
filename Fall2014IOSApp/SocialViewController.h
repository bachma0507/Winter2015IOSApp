//
//  SocialViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/8/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

{
    IBOutlet UIWebView *webView;
}


@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)facebookPressed:(id)sender;
- (IBAction)twitterPressed:(id)sender;


- (IBAction)postTweet:(id)sender;
- (IBAction)postFacebook:(id)sender;
@end
