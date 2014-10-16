//
//  MyFavoritesViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFavoritesViewController : UITableViewController

@property (strong, nonatomic) NSArray *objects;

@property (nonatomic, strong) NSString * exhibitorName;
@property (nonatomic, strong) NSString * boothNumber;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * phone;

//@property (nonatomic, strong) IBOutlet UILabel * exhibitorNameLabel;
//@property (nonatomic, strong) IBOutlet UILabel * boothNumberLabel;

@end
