//
//  SurveysViewController.m
//  Winter2015IOSApp
//
//  Created by Barry on 12/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "SurveysViewController.h"

@interface SurveysViewController ()

@end

@implementation SurveysViewController
@synthesize webView;
@synthesize activity;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    // Do any additional setup after loading the view.
    
    webView.delegate = self;
    
    //NSString *httpSource = @"http://www.speedyreference.com/bicsiappcms/presentationspdf.html";
    NSString *httpSource = @"http://www.bicsi.org/directory/uplink/default.aspx?id=6608";
    //NSString *httpSource = @"http://www.bicsi.org/m/surveys.aspx#one";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
}

- (void)didReceiveMemoryWarning {
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
    activity.hidden = TRUE;
    
    //    [webView stringByEvaluatingJavaScriptFromString:@"var link = document.createElement('link');"
    //     "link.type = 'text/css';"
    //     "link.rel = 'stylesheet';"
    //     "link.href = 'http://www.bicsi.org/m/themes/mobile_custom.css';"
    //     "document.getElementsByTagName('head')[0].appendChild(link);"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
