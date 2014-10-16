//
//  SessionNotes.h
//  Fall2013IOSApp
//
//  Created by Barry on 6/29/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SessionNotes : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * id;

@end
