//
//  notificationViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 5/17/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "notificationViewController.h"

@interface notificationViewController ()

@end

@implementation notificationViewController
@synthesize webView;
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
    
    NSString *httpSource = @"http://www.barrycjulien.com/notifications/index.html";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(tick) userInfo:nil repeats:YES];
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

@end
