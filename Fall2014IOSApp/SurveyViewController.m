//
//  SurveyViewController.m
//  Fall2014IOSApp
//
//  Created by Barry on 6/3/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

@synthesize webView;
@synthesize activity;
@synthesize mySessions;

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
    
    mySessions.sessionID = self.sessionId;
    
    NSLog(@"****SessionID in SurveyViewController is %@",self.sessionId);
    
    NSString * myURL = [NSString stringWithFormat:@"https://www.research.net/s/%@", self.sessionId];
    NSURL *URL = [NSURL URLWithString:myURL];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:httpRequest];
}

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(620.0, 700.0);
    [super awakeFromNib];
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
    activity.hidden = TRUE;
    
     
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
