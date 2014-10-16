//
//  SocialDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/8/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SocialDetailViewController.h"

@interface SocialDetailViewController ()

@end

@implementation SocialDetailViewController

@synthesize webView;
@synthesize socialitems;
@synthesize activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = socialitems.name;
    NSURLRequest *httpRequest = socialitems.httpRequest;
    [webView loadRequest:httpRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)WebView
{
    [activity startAnimating];
    //back.enabled = NO;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
    [activity stopAnimating];
    activity.hidden = TRUE;
    
//    if(WebView.canGoBack == YES)
//	{
//		back.enabled = YES;
//		back.highlighted = YES;
//	}
}


@end
