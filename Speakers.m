//
//  Speakers.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Speakers.h"

@implementation Speakers

//@synthesize speakerID;
@synthesize speakerName;
@synthesize speakerLastName;
@synthesize speakerCompany;
@synthesize speakerCity;
@synthesize speakerState;
@synthesize speakerCountry;
//@synthesize speakerBio;
//@synthesize speakerWebsite;
//@synthesize speakerPic;
@synthesize session1;
@synthesize session1Date;
//@synthesize session1Time;
@synthesize session1Desc;
//@synthesize session2;
//@synthesize session2Date;
//@synthesize session2Time;
//@synthesize session2Desc;
@synthesize sessionID;
//@synthesize sessionID2;
@synthesize startTime;
@synthesize endTime;
@synthesize location;
//@synthesize sess2StartTime;
//@synthesize sess2EndTime;
//@synthesize location2;



-(id) initWithSpeakerName: (NSString *) sName andSpeakerLastName: (NSString *) sLastname andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Desc: (NSString *) sSession1Desc andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation
{
    self = [super init];
    if (self) {
        //speakerID = sID;
        speakerName = sName;
        speakerLastName = sLastname;
        speakerCompany = sCompany;
        speakerCity = sCity;
        speakerState = sState;
        speakerCountry = sCountry;
        //speakerBio = sBio;
        //speakerWebsite = sWebsite;
        //speakerPic = sPic;
        session1 = sSession1;
        session1Date = sSession1Date;
        //session1Time = sSession1Time;
        session1Desc = sSession1Desc;
        //session2 = sSession2;
        //session2Date = sSession2Date;
        //session2Time = sSession2Time;
        //session2Desc = sSession2Desc;
        sessionID = sSessionID;
        //sessionID2 = sSessionID2;
        startTime = sStartTime;
        endTime = sEndTime;
        location = sLocation;
        //sess2StartTime = sSess2StartTime;
        //sess2EndTime = sSess2EndTime;
        //location2 = sLocation2;
        
    }
    
    return self;
}


@end
