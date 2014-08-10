//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

@import Foundation;

#import "RWTFlickrSearchImpl.h"
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "FlickrAPIKeys.h"

@interface RWTFlickrSearchImpl () <OFFlickrAPIRequestDelegate>

@property (strong, nonatomic) NSMutableSet *requests;
@property (strong, nonatomic) OFFlickrAPIContext *flickrContext;

@end

// Concrete implementation of search services in the model layer from the abstract RWTFlickrSearch.
@implementation RWTFlickrSearchImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *OFSampleAppAPIKey = API_KEY;
        NSString *OFSampleAppAPISharedSecret = SHARED_SECRET;

        _flickrContext = [[OFFlickrAPIContext alloc]
                                              initWithAPIKey:OFSampleAppAPIKey
                                              sharedSecret:OFSampleAppAPISharedSecret];
        _requests = [NSMutableSet new];
    }
    return self;
}


- (RACSignal *)flickrSearchSignal:(NSString *)searchString
{
    return [self signalFromAPIMethod:@"flickr.photos.search"
                 arguments:@{@"text" : searchString,
                             @"sort" : @"interestingness-desc"}
                 transform:^id(NSDictionary *response) {

                     RWTFlickrSearchResults
                             *results = [RWTFlickrSearchResults new];
                     results.searchString = searchString;
                     results.totalResults
                             = (NSUInteger)[[response valueForKeyPath:@"photos.total"]
                                                      integerValue];

                     NSArray *photos
                             = [response valueForKeyPath:@"photos.photo"];
                     results.photos = [photos linq_select:^id(
                             NSDictionary *jsonPhoto) {
                         RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
                         photo.title = [jsonPhoto objectForKey:@"title"];
                         photo.identifier = [jsonPhoto objectForKey:@"id"];
                         photo.url = [self
                                 .flickrContext photoSourceURLFromDictionary:jsonPhoto
                                                size:OFFlickrSmallSize];
                         return photo;
                     }];

                     return results;
                 } // End transform block.
    ];
}


- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                         transform:(id (^)(NSDictionary *response))block
{
    // 1. Create a signal for this request
    return [RACSignal createSignal:^RACDisposable *(
            id <RACSubscriber> subscriber) {

        // 2. Create a Flick request object
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc]
                                                                 initWithAPIContext:self
                                                                         .flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];

        // 3. Create a signal from the delegate method
        RACSignal *successSignal
                = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:)
                        fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];

        // 4. Handle the response
        [[[successSignal map:^id(RACTuple *tuple) {
            return tuple.second;
        }] map:block] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];

        // 5. Make the request
        [flickrRequest callAPIMethodWithGET:method arguments:args];

        // 6. When we are done, remove the reference to this request
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }]; // End cleanup
    }];
}

@end
