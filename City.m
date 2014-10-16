//
//  City.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "City.h"

@implementation City

@synthesize cityID;
@synthesize cityName;
@synthesize cityState;
@synthesize cityPopulation;
@synthesize cityCountry;



-(id) initWithCityID: (NSString *) cID andCityName: (NSString *) cName andCityState: (NSString *) cState andCityPopulation: (NSString *) cPopulation andCityCountry: (NSString *) cCountry
{
    self = [super init];
    if (self) {
        cityID = cID;
        cityName = cName;
        cityState = cState;
        cityPopulation = cPopulation;
        cityCountry = cCountry;
    }
    
    return self;
}

@end
