//
//  Sessions.h
//  Fall2013IOSApp
//
//  Created by Barry on 7/11/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sessions : NSObject

//@property (nonatomic, strong) NSString * ID;
//@property (nonatomic, strong) NSString * sessionStatus;
@property (nonatomic, strong) NSString * sessionDay;
@property (nonatomic, strong) NSString * sessionDate;
//@property (nonatomic, strong) NSString * trueDate;
//@property (nonatomic, strong) NSString * sessionTime;
@property (nonatomic, strong) NSString * sessionName;
@property (nonatomic, strong) NSString * sessionSpeaker1;
@property (nonatomic, strong) NSString * speaker1Company;
@property (nonatomic, strong) NSString * sessionSpeaker2;
@property (nonatomic, strong) NSString * speaker2Company;
@property (nonatomic, strong) NSString * sessionSpeaker3;
@property (nonatomic, strong) NSString * speaker3Company;
@property (nonatomic, strong) NSString * sessionSpeaker4;
@property (nonatomic, strong) NSString * speaker4Company;
@property (nonatomic, strong) NSString * sessionSpeaker5;
@property (nonatomic, strong) NSString * speaker5Company;
@property (nonatomic, strong) NSString * sessionSpeaker6;
@property (nonatomic, strong) NSString * speaker6Company;
@property (nonatomic, strong) NSString * sessionSpeaker1lastname;
@property (nonatomic, strong) NSString * sessionSpeaker2lastname;
@property (nonatomic, strong) NSString * sessionSpeaker3lastname;
@property (nonatomic, strong) NSString * sessionSpeaker4lastname;
@property (nonatomic, strong) NSString * sessionSpeaker5lastname;
@property (nonatomic, strong) NSString * sessionSpeaker6lastname;
@property (nonatomic, strong) NSString * sessionDesc;
//@property (nonatomic, strong) NSString * ITSCECS;
@property (nonatomic, strong) NSString * sessionID;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * location;
//@property (nonatomic, strong) NSString * startTimeStr;



//methods
//-(id) initWithID: (NSString *) sID andSessionStatus: (NSString *) sStatus andSessionDay: (NSString *) sDay andSessionDate: (NSString *) sDate andTrueDate: (NSString *) tDate andSessionTime: (NSString *) sTime andSessionName: (NSString *) sName andSessionSpeaker1: (NSString *) sSpeaker1 andSpeaker1Company: (NSString *) sSpeaker1Company andSessionSpeaker2: (NSString *) sSpeaker2 andSpeaker2Company: (NSString *) sSpeaker2Company andSessionSpeaker3: (NSString *) sSpeaker3 andSpeaker3Company: (NSString *) sSpeaker3Company andSessionSpeaker4: (NSString *) sSpeaker4 andSpeaker4Company: (NSString *) sSpeaker4Company andSessionSpeaker5: (NSString *) sSpeaker5 andSpeaker5Company: (NSString *) sSpeaker5Company andSessionSpeaker6: (NSString *) sSpeaker6 andSpeaker6Company: (NSString *) sSpeaker6Company andSessionDesc: (NSString *) sDesc andITSCECS: (NSString *) sITSCECS andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation andStartTimeStr: (NSString *) sStartTimeStr;
-(id) initWithSessionDate: (NSString *) sDate andSessionName: (NSString *) sName andSessionSpeaker1: (NSString *) sSpeaker1 andSpeaker1Company: (NSString *) sSpeaker1Company andSessionSpeaker2: (NSString *) sSpeaker2 andSpeaker2Company: (NSString *) sSpeaker2Company andSessionSpeaker3: (NSString *) sSpeaker3 andSpeaker3Company: (NSString *) sSpeaker3Company andSessionSpeaker4: (NSString *) sSpeaker4 andSpeaker4Company: (NSString *) sSpeaker4Company andSessionSpeaker5: (NSString *) sSpeaker5 andSpeaker5Company: (NSString *) sSpeaker5Company andSessionSpeaker6: (NSString *) sSpeaker6 andSpeaker6Company: (NSString *) sSpeaker6Company andSessionDesc: (NSString *) sDesc andSessionID: (NSString *) sSessionID andStartTime: (NSString *) sStartTime andEndTime: (NSString *) sEndTime andLocation: (NSString *) sLocation andSessionSpeaker1lastname: (NSString *) sSpeaker1lastname andSessionSpeaker2lastname: (NSString *) sSpeaker2lastname andSessionSpeaker3lastname: (NSString *) sSpeaker3lastname andSessionSpeaker4lastname: (NSString *) sSpeaker4lastname andSessionSpeaker5lastname: (NSString *) sSpeaker5lastname andSessionSpeaker6lastname: (NSString *) sSpeaker6lastname;

@end
