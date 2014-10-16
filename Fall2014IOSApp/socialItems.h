//
//  socialItems.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/9/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface socialItems : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *httpSource;
@property (nonatomic, strong) NSURL *fullUrl;
@property (nonatomic, strong) NSURLRequest *httpRequest;

@end
