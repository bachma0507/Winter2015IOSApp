//
//  tabView.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "tabView.h"
#import "NavigationController.h"
#import "GroupView.h"
#import "PrivateView.h"
#import "ProfileView.h"
#import "AppConstant.h"
#import "CustomPagerViewController.h"

@interface tabView ()

@end

@implementation tabView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NavigationController *nc1 = [[NavigationController alloc] initWithRootViewController:[[GroupView alloc] init]];
    NavigationController *nc2 = [[NavigationController alloc] initWithRootViewController:[[PrivateView alloc] init]];
    NavigationController *nc3 = [[NavigationController alloc] initWithRootViewController:[[ProfileView alloc] init]];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc1, nc2, nc3, nil];
    self.tabBarController.tabBar.barTintColor = COLOR_TABBAR_BACKGROUND;
    self.tabBarController.tabBar.tintColor = COLOR_TABBAR_LABEL;
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
