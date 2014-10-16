//
//  DocPath.m
//  Fall2014IOSApp
//
//  Created by Barry on 10/9/14.
//  Copyright (c) 2014 BICSI. All rights reserved.
//

#import "DocPath.h"

@implementation DocPath


+ (NSString *)documentsPath
{
    NSFileManager *fileManager = [NSFileManager new]; // File manager instance
    
    NSURL *pathURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    
    return [pathURL path]; // Path to the application's "~/Documents" directory
}

@end
