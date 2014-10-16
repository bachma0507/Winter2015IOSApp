//
//  ConfSched.h
//  Fall2013IOSApp
//
//  Created by Barry on 8/30/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfSched : NSObject

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSString * date;



//methods
-(id) initWithID: (NSString *) cID andDay: (NSString *) cDay andDate: (NSString *) cDate;

@end
