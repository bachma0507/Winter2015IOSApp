//
//  Html.h
//  Winter2014IOSApp
//
//  Created by Barry on 12/14/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Html : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * ID;

-(id) initWithID: (NSString *) hID andName: (NSString *) hName andUrl: (NSString *) hUrl;

@end
