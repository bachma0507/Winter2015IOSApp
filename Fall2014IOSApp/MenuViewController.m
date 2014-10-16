//
//  MenuViewController.m
//  Fall2014IOSApp
//
//  Created by Barry on 6/10/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "MenuViewController.h"
#import "SponsorsTableViewController.h"


@interface MenuViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation MenuViewController

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
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
}

- (IBAction)onBurger:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"confsched"],
                        [UIImage imageNamed:@"speakers"],
                        [UIImage imageNamed:@"ehschedule"],
                        [UIImage imageNamed:@"sponsors"],
                        [UIImage imageNamed:@"sessions"],
                        [UIImage imageNamed:@"exhibitors"],
                        [UIImage imageNamed:@"favexhibitors"],
                        [UIImage imageNamed:@"mynotes"],
                        [UIImage imageNamed:@"myagenda"],
                        [UIImage imageNamed:@"cecinfo"],
                        [UIImage imageNamed:@"contactus"],
                        [UIImage imageNamed:@"trainingexams"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        
        [self performSegueWithIdentifier:@"segueToConfSched" sender:self];
        
        [sidebar dismissAnimated:YES completion:nil];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"segueToConfSched"]) {
        
        ConfSchedTableViewController *destViewController = segue.destinationViewController;
        destViewController.title = @"";
        [[segue destinationViewController] setDelegate:self];
        
    }

    
}


@end
