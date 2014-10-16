//
//  AgendaDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesViewController.h"
#import <CoreData/CoreData.h>
#import "SurveyViewController.h"

@interface AgendaDetailViewController : UIViewController <NotesViewControllerDelegate, SurveyViewControllerDelegate,UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *NotesPopoverController;
@property (strong, nonatomic) UIPopoverController *SurveyPopoverController;

@property (strong, nonatomic) IBOutlet UILabel *sessionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic, strong) NSString * location;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *objects;


- (IBAction)takeSurvey:(id)sender;

@end
