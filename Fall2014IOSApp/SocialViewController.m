//
//  SocialViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/8/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SocialViewController.h"
#import <Social/Social.h>
#import "SocialDetailViewController.h"
#import "socialItems.h"
#import "SVWebViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController
NSArray *moreSocialItems;
NSArray *thumbnails;


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
    
    
    
//    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
//    self.tableView.contentInset = inset;
//    
//    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]]; //[UIColor clearColor];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    socialItems *item8 = [socialItems new];
    item8.name = @"Facebook";
    item8.httpSource = @"http://m.facebook.com/bicsi";
    item8.fullUrl = [NSURL URLWithString:item8.httpSource];
    item8.httpRequest = [NSURLRequest requestWithURL:item8.fullUrl];
    
    socialItems *item9 = [socialItems new];
    item9.name = @"Twitter";
    item9.httpSource = @"http://mobile.twitter.com/bicsi";
    item9.fullUrl = [NSURL URLWithString:item9.httpSource];
    item9.httpRequest = [NSURLRequest requestWithURL:item9.fullUrl];
    
    moreSocialItems = [NSArray arrayWithObjects:item8, item9, nil];
    
    thumbnails = [NSArray arrayWithObjects:@"facebook.png", @"twitter.png", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreSocialItems count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"socialCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //cell.textLabel.font = [UIFont systemFontOfSize:14.0];//
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:135/255 green:157/255 blue:204/255 alpha:0];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    socialItems *socialitems = [moreSocialItems objectAtIndex:indexPath.row];
    cell.textLabel.text = socialitems.name;
    cell.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"socialDetailCell"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SocialDetailViewController *destViewController = segue.destinationViewController;
        destViewController.socialitems = [moreSocialItems objectAtIndex:indexPath.row];
        
        // Hide bottom tab bar in the detail view
        destViewController.hidesBottomBarWhenPushed = YES;
        
    }
}


- (IBAction)facebookPressed:(id)sender {
    
    //NSString * myURL = [NSString stringWithFormat:@"%@", sponsors.sponsorWebsite];
    //    NSURL *url = [NSURL URLWithString:myURL];
    //	[[UIApplication sharedApplication] openURL:url];
    
    
    
    NSURL *URL = [NSURL URLWithString:@"http://m.facebook.com/bicsi"];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)twitterPressed:(id)sender {
    
    
    
    NSURL *URL = [NSURL URLWithString:@"http://mobile.twitter.com/bicsi"];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)postTweet:(id)sender {
    
    
    
    SLComposeViewController *socialComposerSheet;
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        socialComposerSheet = [[SLComposeViewController alloc] init];
        socialComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        //[socialComposerSheet setInitialText:[NSString stringWithFormat:@"#BICSI, #BICSIFALL",socialComposerSheet.serviceType]];
        [socialComposerSheet setInitialText:[NSString stringWithFormat:@"#BICSI, #BICSIFALL2014"]];
        [self presentViewController:socialComposerSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please make sure Twitter is installed and logged in on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (IBAction)postFacebook:(id)sender {
    
    
    
    SLComposeViewController *socialComposerSheet;
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        socialComposerSheet = [[SLComposeViewController alloc] init];
        socialComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        //[socialComposerSheet setInitialText:[NSString stringWithFormat:@"@BICSI",socialComposerSheet.serviceType]];
        [self presentViewController:socialComposerSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please make sure Facebook is installed and logged in on your device." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
@end
