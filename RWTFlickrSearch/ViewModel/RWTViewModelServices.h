//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTFlickrSearch.h"

// Declare a protocol for providing search services on Flickr.
@protocol RWTViewModelServices <NSObject>

- (id<RWTFlickrSearch>) getFlickrSearchService;

@end
