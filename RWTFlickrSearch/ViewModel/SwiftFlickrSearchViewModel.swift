//
//  SwiftFlickrSearchViewModel.swift
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/6/14.
//  Copyright (c) 2014 Daniel Zhang (張道博). All rights reserved.
//

import Foundation

@objc class SwiftFlickrSearchViewModel: NSObject {

    // Explicitly allow nil objects:
    var searchText: String?
    var title: String?
    var executeSearch: RACCommand?
    var services: RWTViewModelServices?

    override init() {
        super.init()
        self.initialize()
    }

    init(services:RWTViewModelServices) {
        super.init()
        self.services = services
        self.initialize()
    }

    func initialize() {
        self.searchText = "search text"
        self.title = "Swift Flickr Search"

        var validSearchSignal = self.rac_valuesForKeyPath("searchText",
            observer: self).map{(text) -> AnyObject! in
                return (text as NSString).length > 3}.distinctUntilChanged()

        validSearchSignal.subscribeNext{(x) in println("swift search text is valid \(x)")}

        self.executeSearch = RACCommand(enabled: validSearchSignal,
            signalBlock: {(input) -> RACSignal! in println("executing search"); return self.executeSearchSignal()})
    }

    // the viewmodel is obtaining data from the model using services that the model provides.
    func executeSearchSignal() -> RACSignal! {
        println("execute search signal")
        println("services \(self.services)")
        return self.services?.getFlickrSearchService().flickrSearchSignal(self.searchText!).logAll()
    }
}
