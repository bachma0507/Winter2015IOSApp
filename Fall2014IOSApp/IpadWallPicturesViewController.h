//
//  IpadWallPicturesViewController.h
//  Winter2014IOSApp
//
//  Created by Barry on 10/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface IpadWallPicturesViewController : UIViewController

{
    MBProgressHUD *HUD;
    
}

@property (nonatomic, strong) IBOutlet UIScrollView *wallScroll;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actvity;

-(IBAction)logoutPressed:(id)sender;
-(IBAction)refreshView:(id)sender;

@end
