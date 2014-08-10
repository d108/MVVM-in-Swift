//
//  SwiftViewModelServicesImpl.swift
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/7/14.
//  Copyright (c) 2014 Daniel Zhang. All rights reserved.
//

import Foundation

// Implementation of the SwiftViewModelServices protocol that provides access to the search services in the model layer.
@objc class SwiftViewModelServicesImpl:NSObject, SwiftViewModelServices {
    var searchService: SwiftFlickrSearchImpl?

    override init() {
        super.init()
        self.searchService = SwiftFlickrSearchImpl()
    }

    func getFlickrSearchService() -> SwiftFlickrSearch! {
        return self.searchService
    }
}