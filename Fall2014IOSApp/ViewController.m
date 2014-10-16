//
//  ViewController.m
//  YelpNearby
//
//  Created by Behera, Subhransu on 12/5/13.
//  Copyright (c) 2013 Subh. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "ResultTableViewCell.h"



@interface ViewController ()



@end


const unsigned char SpeechKitApplicationKey[] = {0xfd, 0x41, 0x2f, 0x14, 0x90, 0x1a, 0x36, 0x10, 0xa5, 0x19, 0x20, 0x70, 0x22, 0x29, 0x5a, 0x33, 0xdb, 0x27, 0x4c, 0xb3, 0x73, 0x41, 0xda, 0x9a, 0x74, 0xf9, 0x7f, 0xd7, 0xa1, 0xf8, 0x9c, 0x9e, 0x39, 0xcb, 0xb3, 0xc9, 0xe5, 0xe9, 0xd9, 0x8a, 0x02, 0xfa, 0xfa, 0x24, 0x23, 0x55, 0x58, 0xff, 0x7c, 0xa4, 0xb2, 0xef, 0xe5, 0x8d, 0x89, 0x59, 0x86, 0x08, 0x30, 0x27, 0x01, 0xcc, 0xc5, 0x3a};


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.messageLabel.text = @"Tap on the mic to record";
    self.activityIndicator.hidden = YES;
    
    if (!self.tableViewDisplayDataArray) {
        self.tableViewDisplayDataArray = [[NSMutableArray alloc] init];
    }
    
    self.appDelegate = (Fall2013IOSAppAppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate updateCurrentLocation];
    [self.appDelegate setupSpeechKitConnection];
    
    self.searchTextField.returnKeyType = UIReturnKeySearch;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
# pragma mark - TableView Datasource and Delegate methods
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewDisplayDataArray count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell *cell = (ResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
    
    Restaurant *restaurantObj = (Restaurant *)[self.tableViewDisplayDataArray objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = restaurantObj.name;
    cell.addressLabel.text = restaurantObj.address;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *thumbImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantObj.thumbURL]];
        NSData *ratingImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:restaurantObj.ratingURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.thumbImage.image = [UIImage imageWithData:thumbImageData];
            cell.ratingImage.image = [UIImage imageWithData:ratingImageData];
        });
    });
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Restaurant *restaurantObj = (Restaurant *)[self.tableViewDisplayDataArray objectAtIndex:indexPath.row];
    
    if (restaurantObj.yelpURL) {
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:restaurantObj.yelpURL]];
    }
}

# pragma mark - Textfield Delegate Method and Method to handle Button Touch-up Event

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.searchTextField isFirstResponder]) {
        [self.searchTextField resignFirstResponder];
    }
}

# pragma mark - when record button is tapped

- (IBAction)recordButtonTapped:(id)sender {
    self.recordButton.selected = !self.recordButton.isSelected;
    
    // This will initialize a new speech recognizer instance
    if (self.recordButton.isSelected) {
        self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                    detection:SKShortEndOfSpeechDetection
                                                     language:@"en_US"
                                                     delegate:self];
    }
    
    // This will stop existing speech recognizer processes
    else {
        if (self.voiceSearch) {
            [self.voiceSearch stopRecording];
            [self.voiceSearch cancel];
        }
        
        if (self.isSpeaking) {
            [self.vocalizer cancel];
            self.isSpeaking = NO;
        }
    }
}

# pragma mark - SKRecognizer Delegate Methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Listening..";
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Done Listening..";
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results {
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
        self.searchTextField.text = [results firstResult];
    }
    
    self.recordButton.selected = !self.recordButton.isSelected;
    
    // This will extract category filter from search text
    NSString *yelpCategoryFilter = [self getYelpCategoryFromSearchText];
    
    // This will find nearby restaurants by category
    [self findNearByRestaurantsFromYelpbyCategory:yelpCategoryFilter];
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion {
    self.recordButton.selected = NO;
    self.messageLabel.text = @"Connection error";
    self.activityIndicator.hidden = YES;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (NSString *)getYelpCategoryFromSearchText {
    NSString *categoryFilter;
    
    if ([[self.searchTextField.text componentsSeparatedByString:@" restaurant"] count] > 1) {
        NSCharacterSet *separator = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *trimmedWordArray = [[[self.searchTextField.text componentsSeparatedByString:@"restaurant"] firstObject] componentsSeparatedByCharactersInSet:separator];
        
        if ([trimmedWordArray count] > 2) {
            int objectIndex = (int)[trimmedWordArray count] - 2;
            categoryFilter = [trimmedWordArray objectAtIndex:objectIndex];
        }
        
        else {
            categoryFilter = [trimmedWordArray objectAtIndex:0];
        }
    }
    
    else if (([[self.searchTextField.text componentsSeparatedByString:@" restaurant"] count] <= 1)
             && self.searchTextField.text &&  self.searchTextField.text.length > 0){
        categoryFilter = self.searchTextField.text;
    }
    
    return categoryFilter;
}

- (void)findNearByRestaurantsFromYelpbyCategory:(NSString *)categoryFilter {
    if (categoryFilter && categoryFilter.length > 0) {
        if (([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
            && self.appDelegate.currentUserLocation &&
            self.appDelegate.currentUserLocation.coordinate.latitude) {
            
            [self.tableViewDisplayDataArray removeAllObjects];
            [self.resultTableView reloadData];
            
            self.messageLabel.text = @"Fetching results..";
            self.activityIndicator.hidden = NO;
            
            self.yelpService = [[YelpAPIService alloc] init];
            self.yelpService.delegate = self;
            
            self.searchCriteria = categoryFilter;
            
            [self.yelpService searchNearByRestaurantsByFilter:[categoryFilter lowercaseString] atLatitude:self.appDelegate.currentUserLocation.coordinate.latitude andLongitude:self.appDelegate.currentUserLocation.coordinate.longitude];
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location is Disabled"
                                                            message:@"Enable it in settings and try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

# pragma mark - Yelp API Delegate Method

-(void)loadResultWithDataArray:(NSArray *)resultArray {
    self.messageLabel.text = @"Tap on the mic to record";
    self.activityIndicator.hidden = YES;
    
    self.tableViewDisplayDataArray = [resultArray mutableCopy];
    [self.resultTableView reloadData];
    
    if (self.isSpeaking) {
        [self.vocalizer cancel];
    }
    
    self.isSpeaking = YES;
    // 1
    self.vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
    
//    if (([self.searchCriteria isEqualToString:@"restaurants"]) && ([self.tableViewDisplayDataArray count] > 1)) {
//        // 2
//        [self.vocalizer speakString:[NSString stringWithFormat:@"I found %lu %@",
//                                     (unsigned long)[self.tableViewDisplayDataArray count],
//                                     self.searchCriteria]];
//    }
    
    if ([self.tableViewDisplayDataArray count] == 1) {
        // 2
        [self.vocalizer speakString:[NSString stringWithFormat:@"I found %lu %@ restaurant",
                                     (unsigned long)[self.tableViewDisplayDataArray count],
                                     self.searchCriteria]];
    }
    
    else if ([self.tableViewDisplayDataArray count] > 0) {
        // 2
        [self.vocalizer speakString:[NSString stringWithFormat:@"I found %lu %@ restaurants",
                                     (unsigned long)[self.tableViewDisplayDataArray count],
                                     self.searchCriteria]];
    }
    
    else {
        [self.vocalizer speakString:[NSString stringWithFormat:@"I could not find any %@ restaurants",
                                     self.searchCriteria]];
    }
}

- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text {
    self.isSpeaking = YES;
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error {
    if (error !=nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        if (self.isSpeaking) {
            [self.vocalizer cancel];
        }
    }
    
    self.isSpeaking = NO;
}

@end
