//
//  NavigationController.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "NavigationController.h"
#import "AppConstant.h"

@interface NavigationController ()

@end

@implementation NavigationController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = COLOR_NAVBAR_BACKGROUND;
    self.navigationBar.tintColor = COLOR_NAVBAR_BUTTON;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:COLOR_NAVBAR_TITLE};
    self.navigationBar.translucent = NO;
    
}

@end
