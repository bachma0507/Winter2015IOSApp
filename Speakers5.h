//
//  Speakers5.h
//  Fall2014IOSApp
//
//  Created by Barry on 8/1/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Speakers5 : NSObject

@property (nonatomic, strong) NSString * speakerName;
@property (nonatomic, strong) NSString * speakerLastName;
@property (nonatomic, strong) NSString * speakerCompany;
@property (nonatomic, strong) NSString * speakerCity;
@property (nonatomic, strong) NSString * speakerState;
@property (nonatomic, strong) NSString * speakerCountry;
@property (nonatomic, strong) NSString * session1;
@property (nonatomic, strong) NSString * session1Date;
@property (nonatomic, strong) NSString * session1Desc;
@property (nonatomic, strong) NSString * sessionID;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;




//methods
-(id) initWithSpeakerName: (NSString *) sName andSpeakerLastName: (NSString *) sLastname andSpeakerCompany: (NSString *) sCompany andSpeakerCity: (NSString *) sCity andSpeakerState: (NSString *) sState andSpeakerCountry: (NSString *) sCountry andSession1: (NSString *) sSession1 andSession1Date: (NSString *) sSession1Date andSession1Desc: (NSString *) sSession1Desc andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation;

@end
