//
//  FindAreaActivitiesViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 7/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVWebViewController.h"

@class FindAreaActivitiesViewController;

@protocol FindAreaActivitiesViewControllerDelegate

@end

@interface FindAreaActivitiesViewController : UIViewController
@property (weak, nonatomic) id <FindAreaActivitiesViewControllerDelegate> delegate;
- (IBAction)buttonPressed:(id)sender;

@end
