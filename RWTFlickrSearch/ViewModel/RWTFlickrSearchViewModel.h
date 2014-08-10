//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/5/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) RACCommand *executeSearch;

- (instancetype)initWithServices:(id <RWTViewModelServices>)services;

@end
