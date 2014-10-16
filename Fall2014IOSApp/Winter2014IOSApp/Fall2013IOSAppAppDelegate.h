//
//  Fall2013IOSAppAppDelegate.h
//  Fall2013IOSApp
//
//  Created by Barry on 5/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PushIOManager/PushIOManager.h>

@class Reachability;

@interface Fall2013IOSAppAppDelegate : UIResponder <UIApplicationDelegate, PushIOManagerDelegate>
{
    Reachability *internetReach;
}


@property (strong, nonatomic) UIWindow *window;

@end
