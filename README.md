MVVM in Swift
=============
My exercise in converting Objective-C to Swift in ReactiveCocoa 2.1.8 with Xcode 6 Beta 5. It is based on [MVVM
    Tutorial with ReactiveCocoa: Part 1/2](http://www.raywenderlich.com/74106/mvvm-tutorial-with-reactivecocoa-part-1">).

## Blog Posts

* [MVVM in Swift: Part 1](http://blog.ikiapps.com/post/93914146430/mvvm-vc-swift-replacement)
* [MVVM in Swift: Part 2](http://blog.ikiapps.com/post/94050561515/converting-viewmodel-to-swift-for-raywenderlich-tutorial)
* [MVVM in Swift: Part 3](http://blog.ikiapps.com/post/94282530525/translate-flickr-service-to-swift)
* [MVVM in Swift: Part 4](http://blog.ikiapps.com/post/94303519590/linking-model-and-viewmodel)

## Steps To Run

1. Clone the repository.

	    $ git clone git@github.com:dz1111/MVVM-in-Swift.git

2. Install CocoaPods.

		$ cd MVVM-in-Swift
		$ pod install

3. Change the property names in SDWebImage that have build errors to 

		self.executing
		self.finished

	instead of

		_executing
		_finished

4. Create the necessary functions or macros for, or hardcode, your Flickr API key and secret.

5. Open the shared workspace (.xcworkspace) in Xcode.