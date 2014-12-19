//
//  AgendaTableViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/19/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaCell.h"
#import "SubmitMemberIDViewController.h"



@interface AgendaTableViewController : UITableViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) NSArray *objects2;
//@property   (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * location;


//@property (strong, nonatomic) NSArray *dateArray;
//@property (strong, nonatomic) NSMutableDictionary *tempDict;


@end
