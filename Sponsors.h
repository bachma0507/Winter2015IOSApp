//
//  Sponsors.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/17/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sponsors : NSObject

@property (nonatomic, strong) NSString * sponsorID;
@property (nonatomic, strong) NSString * sponsorLevel;
@property (nonatomic, strong) NSString * sponsorSpecial;
@property (nonatomic, strong) NSString * sponsorName;
@property (nonatomic, strong) NSString * boothNumber;
@property (nonatomic, strong) NSString * sponsorWebsite;
@property (nonatomic, strong) NSString * sponsorImage;
@property (nonatomic, strong) NSString * series;


//methods
-(id) initWithSponsorID: (NSString *) sID andSponsorLevel: (NSString *) sLevel andSponsorSpecial: (NSString *) sSpecial andSponsorName: (NSString *) sName andBoothnumber: (NSString *) bNumber andSponsorWebsite: (NSString *) sWebsite andSponsorImage: (NSString *) sImage andSeries: (NSString *) sSeries;


@end
