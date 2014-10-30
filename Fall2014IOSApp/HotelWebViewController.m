//
//  HotelWebViewController.m
//  Canada2014IOSApp
//
//  Created by Barry on 2/13/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "HotelWebViewController.h"

@interface HotelWebViewController ()

@end

@implementation HotelWebViewController

@synthesize webview = _webview;
@synthesize activity = _activity;

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
    
    _webview.delegate = self;
    
    //NSString *httpSource = @"http://www.speedyreference.com/bicsiappcms/hotelinformation.html";
    NSString *httpSource = @"http://www.bicsi.org/directory/uplink/default.aspx?id=7343";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [ _webview loadRequest:httpRequest];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
    
    [_activity startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    [_activity stopAnimating];
    
}

@end
