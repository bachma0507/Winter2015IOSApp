//
//  ShopViewController.h
//  Fall2014IOSApp
//
//  Created by Barry on 7/1/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fall2013IOSAppAppDelegate.h"
#import <SpeechKit/SpeechKit.h>
#import "YelpAPIServiceShop.h"

@interface ShopViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SpeechKitDelegate, SKRecognizerDelegate, YelpAPIServiceDelegate, SKVocalizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@property (strong, nonatomic) Fall2013IOSAppAppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *tableViewDisplayDataArray;

@property (strong, nonatomic) SKRecognizer* voiceSearch;

@property (strong, nonatomic) YelpAPIServiceShop *yelpService;
@property (strong, nonatomic) NSString* searchCriteria;

@property (strong, nonatomic) SKVocalizer* vocalizer;
@property BOOL isSpeaking;

- (NSString *)getYelpCategoryFromSearchText;
- (void)findNearByRestaurantsFromYelpbyCategory:(NSString *)categoryFilter;

- (IBAction)recordButtonTapped:(id)sender;
@end


