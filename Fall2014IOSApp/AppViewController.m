//
//  AppViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/17/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController
@synthesize webView;
@synthesize back;
@synthesize activity;
//@synthesize adImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    //NSString *httpSource = @"http://speedyreference.com/bicsi2.html";
    NSString *httpSource = @"http://www.bicsi.org/m/Login_App.aspx";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIWebViewDelegate methods
//only used here to enable or disable the back and forward buttons
- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
//	back.enabled = NO;
    back.enabled = NO;
    [activity startAnimating];
//	
}
//
- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    [activity stopAnimating];
//    activity.hidden = TRUE;
//	
//	if(thisWebView.canGoBack == YES)
//	{
//		back.enabled = YES;
//		back.highlighted = YES;
//	}
    
    if (thisWebView.canGoBack == YES) {
        back.enabled = YES;
        back.highlighted = YES;
    }
}
- (IBAction)reloadButtonPressed:(id)sender {
    
    [webView reload];
}
- (IBAction)backButtonPressed:(id)sender {
    [webView goBack];
}
@end
