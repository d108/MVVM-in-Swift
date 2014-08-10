//
//  SwiftFlickrSearchImpl.swift
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/8/14.
//  Copyright (c) 2014 Daniel Zhang. All rights reserved.
//

import Foundation

@objc class SwiftFlickrSearchImpl: NSObject, SwiftFlickrSearch, OFFlickrAPIRequestDelegate {
    var searchService: SwiftFlickrSearchImpl
    var requests: NSMutableSet
    var flickrContext: OFFlickrAPIContext


    override init() {
        self.searchService = SwiftFlickrSearchImpl()
        self.flickrContext = OFFlickrAPIContext(APIKey: flickrAPIKey(), sharedSecret: flickrAPISecret())
        self.requests = NSMutableSet()
    }


    func getFlickrSearchService() -> SwiftFlickrSearch {
        return self.searchService
    }


    func flickrSearchSignal(searchString: String) -> RACSignal {
        return self.signalFromAPIMethod("flickr.photos.search",
            arguments: ["text":searchString, "sort":"interestingness-desc"] as NSDictionary,
            transform: { (response:AnyObject!) -> AnyObject! in
                var results = RWTFlickrSearchResults()
                results.searchString = searchString
                results.totalResults = UInt(response.valueForKeyPath("photos.total").integerValue)
                var photos = response.valueForKeyPath("photos.photo") as NSArray
                results.photos = photos.linq_select({ (jsonPhoto) -> AnyObject in
                    var photo = RWTFlickrPhoto()
                    photo.title = jsonPhoto.objectForKey("title") as String
                    photo.identifier = jsonPhoto.objectForKey("id") as String
                    photo.url = self.flickrContext.photoSourceURLFromDictionary(jsonPhoto as NSDictionary, size: OFFlickrSmallSize)
                    return photo
                })
                return results
        })
    }


    func signalFromAPIMethod(method:String, arguments args: NSDictionary, transform block: ((AnyObject!) ->AnyObject!)! ) -> RACSignal {
        return RACSignal.createSignal{ (subscriber:RACSubscriber!) -> RACDisposable in

            // 2. Create a Flick request object
            var flickrRequest = OFFlickrAPIRequest(APIContext: self.flickrContext);
            flickrRequest.delegate = self;
            self.requests.addObject(flickrRequest)

            // 3. Create a signal from the delegate method
            var successSignal = self.rac_signalForSelector("flickrAPIRequest:didCompleteWithResponse:", fromProtocol: OFFlickrAPIRequestDelegate.self)

            // 4. Handle the response
            successSignal.map{(tuple) -> AnyObject in return tuple.second}.map(block).subscribeNext{(x) in
                subscriber.sendNext(x);
                subscriber.sendCompleted()
            }

            // 5. Make the request
            flickrRequest.callAPIMethodWithGET(method, arguments: args)

            // 6. When we are done, remove the reference to this request
            return RACDisposable(block: {self.requests.removeObject(flickrRequest)})}
    }
}