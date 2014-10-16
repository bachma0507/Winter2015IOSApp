//
//  MyFavoritesDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitorNotesViewController.h"
#import <CoreData/CoreData.h>

@interface MyFavoritesDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *exhibitorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *boothNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) NSString * exhibitorName;
@property (nonatomic, strong) NSString * boothNumber;
@property (nonatomic, strong) NSString * boothLabel;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * phone;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;

@end
