//
//  ConferenceScheduleViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ConferenceScheduleViewController.h"

@interface ConferenceScheduleViewController ()

@end

@implementation ConferenceScheduleViewController
@synthesize myWebView;
@synthesize activity;

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
//    NSString *httpSource = @"http://10.210.9.5:83/m/schedule.aspx";
//    NSURL *fullUrl = [NSURL URLWithString:httpSource];
//    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//    [myWebView loadRequest:httpRequest];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"precon.html" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webViewDidStartLoad:(UIWebView *)WebView
{
    [activity startAnimating];
        
}

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
    [activity stopAnimating];
    //activity.hidden = TRUE;
    

}
@end
