//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl ()

@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;

@end

@implementation RWTViewModelServicesImpl

- (instancetype)init {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}

- (id<RWTFlickrSearch>)getFlickrSearchService {
    return self.searchService;
}

@end