//
//  Functions.m
//  Fall2014IOSApp
//
//  Created by Barry on 8/5/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "Functions.h"

@implementation Functions
@synthesize functioncd;

-(id) initWithFunctionCD: (NSString *) fFunctioncd{
    
    self = [super init];
    if (self) {
        functioncd = fFunctioncd;
        
    }
    
    return self;
    
}


@end
