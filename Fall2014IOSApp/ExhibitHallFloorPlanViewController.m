//
//  ExhibitHallFloorPlanViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExhibitHallFloorPlanViewController.h"
#import "SVWebViewController.h"

@interface ExhibitHallFloorPlanViewController ()

@end

@implementation ExhibitHallFloorPlanViewController
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
    
    [TestFlight passCheckpoint:@"ExhibitHallFloorPlan-viewed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    webView.delegate = self;

	// Do any additional setup after loading the view.
    
    
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (screenSize.height > 480.0f) {
//            /*Do iPhone 5 stuff here.*/
//            NSString *httpSource = @"http://barrycjulien.com/floormap/boothinfowin14.htm";
//            NSURL *fullUrl = [NSURL URLWithString:httpSource];
//            NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//            [webView loadRequest:httpRequest];
//        } else {
//            /*Do iPhone Classic stuff here.*/
//            NSString *httpSource = @"http://s23.a2zinc.net/clients/BICSI/winter2014/Public/GeneratePDF.aspx?IMID=undefined&EventId=21&MapId=21";
//            NSURL *fullUrl = [NSURL URLWithString:httpSource];
//            NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//            [webView loadRequest:httpRequest];
//        }
//    } else {
//        /*Do iPad stuff here.*/
//        NSString *httpSource = @"http://barrycjulien.com/floormap/boothinfowin14.htm";
//        NSURL *fullUrl = [NSURL URLWithString:httpSource];
//        NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//        [webView loadRequest:httpRequest];
//
//        
//    }
    
    NSString *httpSource = @"http://barrycjulien.com/floormap/boothinfofall14.htm";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    
    //NSString *httpSource = @"http://s23.a2zinc.net/clients/BICSI/fall2013//Public/GeneratePDF.aspx?IMID=undefined&EventId=20&MapId=20";
//    NSString *httpSource = @"http://barrycjulien.com/floormap/boothinfoRevised.htm";
//    NSURL *fullUrl = [NSURL URLWithString:httpSource];
//    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//    [webView loadRequest:httpRequest];
    
//    NSString * myURL = [NSString stringWithFormat:@"http://barrycjulien.com/floormap/boothinfoRevised.htm"];
//    NSURL *URL = [NSURL URLWithString:myURL];
//	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
//	[self.navigationController pushViewController:webViewController animated:YES];
    
    [webView reload];
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

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[ request URL ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: requestURL];
        //SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:requestURL];
        //[self.navigationController pushViewController:webViewController animated:YES];
    }
    //[ requestURL release ];
    return YES;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    [webView reload];
//    
//    
//}

//- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
//    recognizer.scale = 1;
//}
//
//- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
//    
//    CGPoint translation = [recognizer translationInView:self.view];
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                         recognizer.view.center.y + translation.y);
//    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
//    
//}

@end
