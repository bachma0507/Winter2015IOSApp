//
//  LocateOnMapViewController.m
//  Winter2014IOSApp
//
//  Created by Barry on 11/3/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "LocateOnMapViewController.h"
//#import "SVWebViewController.h"

@interface LocateOnMapViewController ()

@end

@implementation LocateOnMapViewController

@synthesize webView;
@synthesize activity;
@synthesize boothLabel;
@synthesize myExhibitors;
@synthesize name;

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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
	// Do any additional setup after loading the view.
    
    myExhibitors.boothLabel = self.boothLabel;
    myExhibitors.name = self.name;
    
    webView.delegate = self;
    
    
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        if (screenSize.height > 480.0f) {
//            /*Do iPhone 5 stuff here.*/
//            NSString *httpSource = [NSString stringWithFormat:@"http://barrycjulien.com/floormap/boothinfowin14.htm?hotspot=%@",self.boothLabel];
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
//        NSString *httpSource = [NSString stringWithFormat:@"http://barrycjulien.com/floormap/boothinfowin14.htm?hotspot=%@",self.boothLabel];
//        NSURL *fullUrl = [NSURL URLWithString:httpSource];
//        NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
//        [webView loadRequest:httpRequest];
//        
//        
//    }
    
    NSString *httpSource = [NSString stringWithFormat:@"http://barrycjulien.com/floormap/boothinfofall14par.htm?hotspot=%@",self.boothLabel];
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



//
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
