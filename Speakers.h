//
//  Speakers.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/16/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Speakers : NSObject

//@property (nonatomic, strong) NSString * speakerID;
@property (nonatomic, strong) NSString * speakerName;
@property (nonatomic, strong) NSString * speakerLastName;
@property (nonatomic, strong) NSString * speakerCompany;
@property (nonatomic, strong) NSString * speakerCity;
@property (nonatomic, strong) NSString * speakerState;
@property (nonatomic, strong) NSString * speakerCountry;
//@property (nonatomic, strong) NSString * speakerBio;
//@property (nonatomic, strong) NSString * speakerWebsite;
//@property (nonatomic, strong) NSString * speakerPic;
@property (nonatomic, strong) NSString * session1;
@property (nonatomic, strong) NSString * session1Date;
//@property (nonatomic, strong) NSString * session1Time;
@property (nonatomic, strong) NSString * session1Desc;
//@property (nonatomic, strong) NSString * session2;
//@property (nonatomic, strong) NSString * session2Date;
//@property (nonatomic, strong) NSString * session2Time;
//@property (nonatomic, strong) NSString * session2Desc;
@property (nonatomic, strong) NSString * sessionID;
//@property (nonatomic, strong) NSString * sessionID2;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;
//@property (nonatomic, strong) NSString * sess2StartTime;
//@property (nonatomic, strong) NSString * sess2EndTime;
//@property (nonatomic, strong) NSString * location2;



//methods
-(id) initWithSpeakerName: (NSString *) sName andSpeakerLastName: (NSString *) sLastname andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Desc: (NSString *) sSession1Desc andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation;


@end
