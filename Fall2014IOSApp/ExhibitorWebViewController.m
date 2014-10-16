//
//  ExhibitorWebViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 7/31/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitorWebViewController.h"

@interface ExhibitorWebViewController ()

@end

@implementation ExhibitorWebViewController
@synthesize myExhibitors, coId, boothId, eventId, myWebView, activity;

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
    
    myExhibitors.coId = self.coId;
    myExhibitors.eventId = self.eventId;
    myExhibitors.boothId = self.boothId;
    
    myWebView.delegate = self;
    
    NSString * myURL = [NSString stringWithFormat:@"http://s23.a2zinc.net/clients/BICSI/fall2013/public/eBooth.aspx?Nav=false&BoothID=%@&EventID=%@&CoID=%@&Source=ExhibitorList", self.boothId, self.eventId, self.coId];
    NSURL *fullUrl = [NSURL URLWithString:myURL];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [myWebView loadRequest:httpRequest];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activity startAnimating];
    
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [myWebView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 0.58;"];
    
    //NSLog(@"webViewDidFinishLoad is called.");
    
    [activity stopAnimating];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[ request URL ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
    }
    //[ requestURL release ];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
