//
//  SplashViewController.m
//  BICSIapp
//
//  Created by Barry on 4/27/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import "SplashController.h"
#import "BICSIappViewController.h"

@implementation SplashController
@synthesize wheel = _wheel;


- (void)viewDidUnload{
    self.wheel = nil;
    [super viewDidUnload];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) viewDidLoad
{

    
    [super viewDidLoad];
    
    /*if(IS_HEIGHT_GTE_568){
        CGRect frame = self.wheel.frame;
        frame.origin.y += 44;
        [self.wheel setFrame:frame];
    }*/
}

- (void)hideSplash
{
    // show main controller
    [self presentModalViewController:[[BICSIappViewController alloc] init] animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
