//
//  Sponsors.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/17/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Sponsors.h"

@implementation Sponsors
@synthesize sponsorID;
@synthesize sponsorLevel;
@synthesize sponsorSpecial;
@synthesize sponsorName;
@synthesize boothNumber;
@synthesize sponsorWebsite;
@synthesize sponsorImage;
@synthesize series;




-(id) initWithSponsorID: (NSString *) sID andSponsorLevel: (NSString *) sLevel andSponsorSpecial: (NSString *) sSpecial andSponsorName: (NSString *) sName andBoothnumber: (NSString *) bNumber andSponsorWebsite:(NSString *)sWebsite andSponsorImage:(NSString *)sImage andSeries: (NSString *) sSeries
{
    self = [super init];
    if (self) {
        sponsorID = sID;
        sponsorLevel = sLevel;
        sponsorSpecial = sSpecial;
        sponsorName = sName;
        boothNumber = bNumber;
        sponsorWebsite = sWebsite;
        sponsorImage = sImage;
        series = sSeries;
        
        
    }
    
    return self;
}

@end
