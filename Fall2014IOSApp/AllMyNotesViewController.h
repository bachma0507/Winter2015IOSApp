//
//  AllMyNotesViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AllNotesCell.h"

@interface AllMyNotesViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;

@end
