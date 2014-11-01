//
//  SponsorsDetailViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "SponsorsDetailViewController.h"
#import "SVWebViewController.h"
#import "LocateOnMapViewController.h"

@interface SponsorsDetailViewController ()

@end

@implementation SponsorsDetailViewController

@synthesize name;
@synthesize image;
@synthesize website;
@synthesize sponsors;
@synthesize sponsorsNameLabel;
@synthesize sponsorsImage;
@synthesize sponsorsWebsite;
@synthesize boothNumber;

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
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.title = sponsors.sponsorName;
    
    //set our labels
    //sponsorsNameLabel.text = sponsors.sponsorName;
    sponsorsNameLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
    sponsorsNameLabel.textColor = [UIColor blueColor];
    
    NSString * myFile = [NSString stringWithFormat:@"%@", sponsors.sponsorImage];
    
    NSLog(@"Image name is: %@", myFile);
    
    UIImage* myImage = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                         [NSURL URLWithString: myFile]]];
    [sponsorsImage setImage:myImage];
    
    //NSString * myImage = [NSString stringWithFormat:@"%@", sponsors.sponsorImage];
    
    //sponsorsImage.image = [UIImage imageNamed:myImage];
    
    
    //speakerWebsite.text = speakers.speakerWebsite;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    NSString * myURL = [NSString stringWithFormat:@"%@", sponsors.sponsorWebsite];
//    NSURL *url = [NSURL URLWithString:myURL];
//	[[UIApplication sharedApplication] openURL:url];
    NSURL *URL = [NSURL URLWithString:myURL];
	SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"locationDetail"]) {
        self.boothNumber = sponsors.boothNumber;
        self.name = sponsors.sponsorName;
        
        LocateOnMapViewController *destViewController = segue.destinationViewController;
        //destViewController.title = nameLabel.text;
        destViewController.boothLabel = self.boothNumber;
        destViewController.title = self.name;
        
        NSLog(@"Booth Label is %@", self.boothNumber);
    }

    
    
}
@end
