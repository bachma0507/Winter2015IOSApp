//
//  SplashViewController.h
//  BICSIapp
//
//  Created by Barry on 4/27/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import <UIKit/UIKit.h>


/*@interface BICSIappViewController : UIViewController;

@end*/

@interface SplashController : UIViewController {
    UIActivityIndicatorView *wheel;
}
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *wheel;

- (void)hideSplash;

@end


