//
//  SponsorsDetailViewController.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sponsors.h"


@interface SponsorsDetailViewController : UIViewController

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, strong) NSString * website;
@property (nonatomic, strong) NSString * boothNumber;


@property (strong, nonatomic) IBOutlet UILabel *sponsorsNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorsImage;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorsWebsite;

@property (nonatomic, strong) Sponsors * sponsors;

- (IBAction)buttonPressed:(id)sender;

@end
