//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"

@implementation RWTFlickrSearchResults

- (NSString *)description
{
    return [NSString stringWithFormat:@"searchString=%@, totalresults=%lU, photos=%@",
                                      self.searchString, self.totalResults,
                                      self.photos];
}

@end
