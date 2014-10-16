//
//  ConfSched.m
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ConfSched.h"

@implementation ConfSched
@synthesize ID;
@synthesize day;
@synthesize date;


-(id) initWithID: (NSString *) cID andDay: (NSString *) cDay andDate: (NSString *) cDate
{
    self = [super init];
    if (self) {
        
        ID = cID;
        day = cDay;
        date = cDate;
        
    }
    return self;}

@end
