//
//  hotels.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotels : NSObject

@property (nonatomic, strong) NSString * hotelID;
@property (nonatomic, strong) NSString * hotelStatus;
@property (nonatomic, strong) NSString * hotelName;
@property (nonatomic, strong) NSString * hotelAddress;
@property (nonatomic, strong) NSString * hotelCity;
@property (nonatomic, strong) NSString * hotelState;
@property (nonatomic, strong) NSString * hotelZip;
@property (nonatomic, strong) NSString * hotelTelephone;
@property (nonatomic, strong) NSString * hotelWebsite;
@property (nonatomic, strong) NSString * hotelResWebsite;
@property (nonatomic, strong) NSString * hotelDescription;
@property (nonatomic, strong) NSString * hotelAlert;
@property (nonatomic, strong) NSString * hotelCountry;
@property (nonatomic, strong) NSString * groupCode;
@property (nonatomic, strong) NSString * resDate;
@property (nonatomic, strong) NSString * alertLine;

//methods
-(id) initWithHoteID: (NSString *) hID andHotelStatus: (NSString *) hStatus andHotelName: (NSString *) hName andHotelAddress: (NSString *) hAddress andHotelCity: (NSString *) hCity andHotelState: (NSString *) hState andHotelZip: (NSString *) hZip andHotelTelephone: (NSString *) hTelephone andHotelWebsite: (NSString *) hWebsite andHotelResWebsite: (NSString *) hResWebsite andHotelDescription: (NSString *) hDescription andHotelAlert: (NSString *) hAlert andHotelCountry: (NSString *) hCountry andGroupCode: (NSString *) hGroupCode andResDate: (NSString *) hResDate andAlertLine: (NSString *) hAlertLine;

@end
