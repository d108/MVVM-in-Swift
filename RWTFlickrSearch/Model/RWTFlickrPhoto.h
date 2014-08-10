//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

// represents a single photo returned by flickr
@interface RWTFlickrPhoto : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *identifier;

@end
