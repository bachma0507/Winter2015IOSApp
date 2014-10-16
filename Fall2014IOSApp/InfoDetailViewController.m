//
//  InfoDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/2/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "InfoDetailViewController.h"

@interface InfoDetailViewController ()

@end

@implementation InfoDetailViewController

@synthesize webView;
@synthesize infoitems;
@synthesize activity;
@synthesize back;


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
    
    
    self.title = infoitems.name;
    //NSString *httpSource = infoitems.httpSource;
    //NSURL *fullUrl = infoitems.fullUrl;
    NSURLRequest *httpRequest = infoitems.httpRequest;
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
    back.enabled = NO;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
    [activity stopAnimating];
    activity.hidden = TRUE;
    
    if(WebView.canGoBack == YES)
	{
		back.enabled = YES;
		back.highlighted = YES;
	}
}


- (IBAction)backButtonPressed:(id)sender {
    
    [webView goBack];
}

#pragma mark UIWebViewDelegate methods
//only used here to enable or disable the back and forward buttons

//- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
//{
//    [activity stopAnimating];
//    activity.hidden = TRUE;
//	
//	if(thisWebView.canGoBack == YES)
//	{
//		back.enabled = YES;
//		back.highlighted = YES;
//	}
//}

@end
