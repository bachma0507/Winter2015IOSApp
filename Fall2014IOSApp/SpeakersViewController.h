//
//  SpeakersViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speakers.h"
#import "SpeakerDetailViewController.h"
@class MBProgressHUD;

@interface SpeakersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    MBProgressHUD *HUD;
}


@property (nonatomic, strong) NSMutableArray * json;
@property (nonatomic, strong) NSMutableArray * speakersArray;
@property (nonatomic, strong) NSMutableArray * results;
//@property BOOL isFiltered;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *objects;

//@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;


//#pragma mark - Methods
//-(void) retrieveData;
//- (void)fetchedData:(NSData *)responseData;

@end
