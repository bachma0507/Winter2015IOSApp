//
//  EulaViewController.m
//  Canada2014IOSApp
//
//  Created by Barry on 3/26/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "EulaViewController.h"

@interface EulaViewController ()

@end

@implementation EulaViewController
@synthesize activity, webView;

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
    
    webView.delegate = self;
    
    NSString *httpSource = @"http://www.speedyreference.com/bicsiappcms/eula.html";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [ webView loadRequest:httpRequest];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
    
    [activity startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    [activity stopAnimating];
    
}

- (IBAction)okPressed:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
