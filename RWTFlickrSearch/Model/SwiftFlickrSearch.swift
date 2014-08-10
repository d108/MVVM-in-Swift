//
//  RWTFlickrSearch.swift
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/8/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import Foundation

@objc protocol SwiftFlickrSearch {
    func flickrSearchSignal(searchString:String) -> RACSignal
}