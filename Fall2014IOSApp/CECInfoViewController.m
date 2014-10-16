//
//  CECInfoViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "CECInfoViewController.h"

@interface CECInfoViewController ()

@end

@implementation CECInfoViewController
@synthesize webView,json, htmlArray, objects, activity;



- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    
    [TestFlight passCheckpoint:@"CEC-info-viewed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
  
        
    
    //[self getURL];
    
    
    //NSManagedObject *object = [self.objects objectAtIndex:0];
   // NSString *myURL = [[NSString alloc] initWithFormat:@"%@", [object valueForKey:@"url"]];
    //NSLog(@"Value for URL is: %@",myURL);
    
    webView.delegate = self;
    
    
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"cec.html" ofType:nil]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    
    NSString *httpSource = @"http://www.bicsi.org/directory/uplink/default.aspx?id=7005";
    //NSString *httpSource = @"http://www.speedyreference.com/bicsiappcms/cec.html";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
    

}

//-(void)getURL
//
//{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Html" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    //[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"title != 'Todo with Image'"]];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == 'cec'"]];
//    
//    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
//    
//    //[self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
//    //[self.refreshControl endRefreshing];
//    self.objects = results;
//    //    if (!results || !results.count){
//    //        [self.agendaButton setTitle:@"Add to Planner" forState:normal];
//    //
//    //    }
//    //    else{
//    //        [self.agendaButton setTitle:@"Remove from Planner" forState:normal];
//    //    }
//}

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
    
//    [webView stringByEvaluatingJavaScriptFromString:@"var link = document.createElement('link');"
//     "link.type = 'text/css';"
//     "link.rel = 'stylesheet';"
//     "link.href = 'http://www.bicsi.org/m/themes/mobile_custom.css';"
//     "document.getElementsByTagName('head')[0].appendChild(link);"];
    



}

@end

