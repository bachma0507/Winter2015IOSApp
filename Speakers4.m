//
//  Speakers4.m
//  Fall2014IOSApp
//
//  Created by Barry on 8/1/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "Speakers4.h"

@implementation Speakers4

@synthesize speakerName;
@synthesize speakerLastName;
@synthesize speakerCompany;
@synthesize speakerCity;
@synthesize speakerState;
@synthesize speakerCountry;
@synthesize session1;
@synthesize session1Date;
@synthesize session1Desc;
@synthesize sessionID;
@synthesize startTime;
@synthesize endTime;
@synthesize location;




-(id) initWithSpeakerName: (NSString *) sName andSpeakerLastName: (NSString *) sLastname andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Desc: (NSString *) sSession1Desc andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation
{
    self = [super init];
    if (self) {
        
        speakerName = sName;
        speakerLastName = sLastname;
        speakerCompany = sCompany;
        speakerCity = sCity;
        speakerState = sState;
        speakerCountry = sCountry;
        session1 = sSession1;
        session1Date = sSession1Date;
        session1Desc = sSession1Desc;
        sessionID = sSessionID;
        startTime = sStartTime;
        endTime = sEndTime;
        location = sLocation;
        
    }
    
    return self;
}


@end
