//
//  EHSchedule.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/18/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHSchedule : NSObject

@property (nonatomic, strong) NSString * scheduleID;
@property (nonatomic, strong) NSString * scheduleDate;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionTime;
@property (nonatomic, strong) NSString * startTime;


//methods
-(id) initWithScheduleID: (NSString *) sID andScheduleDate: (NSString *) sDate andSessionName: (NSString *) sName andSessionTime: (NSString *) sTime andStartTime: (NSString *) sStartTime;


@end
