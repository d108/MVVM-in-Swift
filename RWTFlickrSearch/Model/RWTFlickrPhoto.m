//
//  RWTFlickrPhoto.m
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhoto.h"

@implementation RWTFlickrPhoto

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.title, self.url];
}

@end
