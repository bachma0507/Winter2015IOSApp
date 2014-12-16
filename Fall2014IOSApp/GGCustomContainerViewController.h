//
//  GGCustomContainerViewController.h
//  Winter2015IOSApp
//
//  Created by Barry on 12/15/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGCustomContainerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property UIViewController * currentVC;
@property (strong, nonatomic) IBOutlet UIView * contentView;

@end
