//
//  CSchedule.h
//  Winter2014IOSApp
//
//  Created by Barry on 12/13/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSchedule : NSObject

@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSString * trueDate;


//methods
-(id) initWithID: (NSString *) sID andDate: (NSString *) sDate andDay: (NSString *) sDay andTrueDate: (NSString *) sTrueDate;


@end
