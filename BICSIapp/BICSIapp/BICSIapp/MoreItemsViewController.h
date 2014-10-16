//
//  MoreItemsViewController.h
//  BICSIapp
//
//  Created by Barry on 4/25/13.
//  Copyright (c) 2013 Barry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICSIitems.h"

@interface MoreItemsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *moreItemsLabel;
@property (nonatomic, strong) NSString *moreItemsName;
@property (weak, nonatomic) IBOutlet UIImageView *itemPhoto;
@property (weak, nonatomic) IBOutlet UITextView *itemTextView;

@property (nonatomic, strong) BICSIitems *bicsiitems;

@end
