//
//  CSchedule.m
//  Winter2014IOSApp
//
//  Created by Barry on 12/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "CSchedule.h"

@implementation CSchedule

@synthesize ID, date, day, trueDate;

-(id) initWithID: (NSString *) sID andDate: (NSString *) sDate andDay: (NSString *) sDay andTrueDate: (NSString *) sTrueDate

{
    
    self = [super init];
    if (self) {
        
        ID = sID;
        date = sDate;
        day = sDay;
        trueDate = sTrueDate;
                
    }
    return self;
}

@end
