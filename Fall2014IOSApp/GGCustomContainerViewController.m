//
//  GGCustomContainerViewController.m
//  Winter2015IOSApp
//
//  Created by Barry on 12/15/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "GGCustomContainerViewController.h"

@interface GGCustomContainerViewController ()

@end

@implementation GGCustomContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    UIViewController *vc = [self viewControllerForSegmentIndex:self.segmentControl.selectedSegmentIndex];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    self.currentVC = vc;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:self.currentVC toViewController:vc duration:0.5 options:0 animations:^{
        [self.currentVC.view removeFromSuperview];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
    } completion:^(BOOL finished) {
        [vc didMoveToParentViewController:self];
        [self.currentVC removeFromParentViewController];
        self.currentVC = vc;
    }];
    self.navigationItem.title = vc.title;
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"All Schedule"];
            break;
        case 1:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"My Schedule"];
            break;
    }
    return vc;
}


@end
