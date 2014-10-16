//
//  City.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/15/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * cityID;
@property (nonatomic, strong) NSString * cityState;
@property (nonatomic, strong) NSString * cityPopulation;
@property (nonatomic, strong) NSString * cityCountry;

//methods
-(id) initWithCityID: (NSString *) cID andCityName: (NSString *) cName andCityState: (NSString *) cState andCityPopulation: (NSString *) cPopulation andCityCountry: (NSString *) cCountry;

@end
