//
//  hotels.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/21/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "hotels.h"

@implementation hotels
@synthesize hotelID, hotelStatus, hotelName, hotelAddress, hotelCity, hotelState, hotelZip, hotelCountry, hotelTelephone, hotelWebsite, hotelResWebsite, hotelDescription, hotelAlert, groupCode, resDate, alertLine;




-(id) initWithHoteID: (NSString *) hID andHotelStatus: (NSString *) hStatus andHotelName: (NSString *) hName andHotelAddress: (NSString *) hAddress andHotelCity: (NSString *) hCity andHotelState: (NSString *) hState andHotelZip: (NSString *) hZip andHotelTelephone: (NSString *) hTelephone andHotelWebsite: (NSString *) hWebsite andHotelResWebsite: (NSString *) hResWebsite andHotelDescription: (NSString *) hDescription andHotelAlert: (NSString *) hAlert andHotelCountry: (NSString *) hCountry andGroupCode: (NSString *) hGroupCode andResDate: (NSString *) hResDate andAlertLine:(NSString *)hAlertLine
{
    self = [super init];
    if (self) {
        hotelID = hID;
        hotelStatus = hStatus;
        hotelName = hName;
        hotelAddress = hAddress;
        hotelCity = hCity;
        hotelState = hState;
        hotelZip = hZip;
        hotelCountry = hCountry;
        hotelTelephone = hTelephone;
        hotelWebsite = hWebsite;
        hotelResWebsite = hResWebsite;
        hotelDescription = hDescription;
        hotelAlert = hAlert;
        groupCode = hGroupCode;
        resDate = hResDate;
        alertLine = hAlertLine;
        
    }
    
    return self;
}

@end
