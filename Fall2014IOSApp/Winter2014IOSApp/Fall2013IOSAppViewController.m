//
//  Fall2013IOSAppViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Fall2013IOSAppViewController.h"

@interface Fall2013IOSAppViewController ()

@end

@implementation Fall2013IOSAppViewController
@synthesize webView;
@synthesize back;
@synthesize activity;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *httpSource = @"http://www.bicsi.org/fall/2013/default.aspx";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.0/1.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

-(void)tick{
    if(!webView.loading)
        [activity stopAnimating];
    else
        [activity startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    
    [webView goBack];
}

#pragma mark UIWebViewDelegate methods
//only used here to enable or disable the back and forward buttons
- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
	back.enabled = NO;
	
}

- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    
	
	if(thisWebView.canGoBack == YES)
	{
		back.enabled = YES;
		back.highlighted = YES;
	}
}
@end
