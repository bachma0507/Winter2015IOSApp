//
//  Html.m
//  Winter2014IOSApp
//
//  Created by Barry on 12/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "Html.h"

@implementation Html

@synthesize name;
@synthesize ID;
@synthesize url;

-(id) initWithID: (NSString *) hID andName: (NSString *) hName andUrl: (NSString *) hUrl
{
    self = [super init];
    if (self) {
        ID = hID;
        name = hName;
        url = hUrl;
        
    }
    
    return self;
}

@end
