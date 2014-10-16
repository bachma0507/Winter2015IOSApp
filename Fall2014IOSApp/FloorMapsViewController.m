//
//  FloorMapsViewController.m
//  Canada2014IOSApp
//
//  Created by Barry on 3/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "FloorMapsViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface FloorMapsViewController ()

@end

@implementation FloorMapsViewController
@synthesize imageView, imageView2;

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
    
    CALayer *layer = self.imageView.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;
    
    CALayer *layer2 = self.imageView2.layer;
    layer2.masksToBounds = NO;
    layer2.shadowRadius = 3.0f;
    layer2.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer2.shadowOpacity = 0.5f;
    layer2.shouldRasterize = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
