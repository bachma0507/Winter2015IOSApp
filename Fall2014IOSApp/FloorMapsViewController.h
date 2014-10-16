//
//  FloorMapsViewController.h
//  Canada2014IOSApp
//
//  Created by Barry on 3/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloorMapsViewController;

@protocol FloorMapsViewControllerDelegate

@end

@interface FloorMapsViewController : UIViewController
@property (weak, nonatomic) id <FloorMapsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;

@end
