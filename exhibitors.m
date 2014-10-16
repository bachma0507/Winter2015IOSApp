//
//  exhibitors.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "exhibitors.h"

@implementation exhibitors
//@synthesize boothlabel, name, url, mapid, coid, eventid, boothid;
//
//
//-(id) initWithBoothName:(NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL andMapId: (NSString *) bmapId andCoId: (NSString *) bcoId andEventId: (NSString *) beventId andBoothId: (NSString *) bboothId
//{
//    
//    self = [super init];
//    if (self) {
//        boothid = bboothId;
//        name = bName;
//        boothlabel = blabel;
//        url = bURL;
//        mapid = bmapId;
//        coid = bcoId;
//        eventid = beventId;
//        
//    }
//    
//    return self;
//}

@synthesize boothLabel, name, url, mapId, coId, eventId, boothId, phone;


-(id) initWithBoothName:(NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL andMapId: (NSString *) bmapId andCoId: (NSString *) bcoId andEventId: (NSString *) beventId andBoothId: (NSString *) bboothId andPhone: (NSString *) bphone
{
    
    self = [super init];
    if (self) {
        boothId = bboothId;
        name = bName;
        boothLabel = blabel;
        url = bURL;
        mapId = bmapId;
        coId = bcoId;
        eventId = beventId;
        phone = bphone;
        
    }
    
    return self;
}

@end
