//
//  exhibitors.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/26/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface exhibitors : NSObject



@property (nonatomic, strong) NSString * boothLabel;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * mapId;
@property (nonatomic, strong) NSString * coId;
@property (nonatomic, strong) NSString * eventId;
@property (nonatomic, strong) NSString * boothId;
@property (nonatomic, strong) NSString * phone;


//methods
//-(id) initWithBoothID: (NSString *) bID andBoothName: (NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL;

-(id) initWithBoothName:(NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL andMapId: (NSString *) bmapId andCoId: (NSString *) bcoId andEventId: (NSString *) beventId andBoothId: (NSString *) bboothId andPhone: (NSString *) bphone;

//@property (nonatomic, strong) NSString * boothlabel;
//@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * url;
//@property (nonatomic, strong) NSString * mapid;
//@property (nonatomic, strong) NSString * coid;
//@property (nonatomic, strong) NSString * eventid;
//@property (nonatomic, strong) NSString * boothid;
//
//
//
////methods
////-(id) initWithBoothID: (NSString *) bID andBoothName: (NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL;
//
//-(id) initWithBoothName:(NSString *) bName andboothLabel: (NSString *) blabel andBoothURL: (NSString *) bURL andMapId: (NSString *) bmapId andCoId: (NSString *) bcoId andEventId: (NSString *) beventId andBoothId: (NSString *) bboothId;

@end

