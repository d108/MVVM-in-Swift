//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/5/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTViewModelServices.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewModel ()

@property (nonatomic, weak) id <RWTViewModelServices> services;

@end

@implementation RWTFlickrSearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}


- (instancetype)initWithServices:(id <RWTViewModelServices>)services
{
    self = [super init];
    if (self) {
        [self initialize];
        self.services = services;
    }
    return self;
}


- (void)initialize
{
    self.searchText = @"search text";
    self.title = @"Flickr Search";

    RACSignal *validSearchSignal = [[RACObserve(self, searchText)
            map:^id(NSString *text) {
                return @(text.length > 3);
            }] distinctUntilChanged];

    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"search text is valid %@", x);
    }];

    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal
                                      signalBlock:^RACSignal *(id input) {
                                          NSLog(@"executing search");
                                          return [self executeSearchSignal];
                                      }];
}


- (RACSignal *)executeSearchSignal
{
    return [[[self.services getFlickrSearchService]
                            flickrSearchSignal:self.searchText] logAll];
}

@end
