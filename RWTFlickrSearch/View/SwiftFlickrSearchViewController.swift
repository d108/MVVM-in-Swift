//
//  SwiftFlickrSearchViewController.swift
//  RWTFlickrSearch
//
//  Created by Daniel Zhang (張道博) on 8/5/14.
//  Copyright (c) 2014 Daniel Zhang (張道博). All rights reserved.
//

import Foundation
import UIKit

@objc class SwiftFlickrSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var viewModel:SwiftFlickrSearchViewModel?
    @IBOutlet var searchTextField:UITextField?
    @IBOutlet var searchButton:UIButton?
    @IBOutlet var searchHistoryTable:UITableView?
    @IBOutlet var loadingIndicator:UIActivityIndicatorView?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        println("initing nib")
        super.init(nibName: "RWTFlickrSearchViewController", bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    init(viewModel: SwiftFlickrSearchViewModel) {
        super.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println("Swift view did load")
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.bindViewModel()
//        self.searchHistoryTable?.registerClass(RWTSearchResultsTableViewCell.self, forCellReuseIdentifier: "Cell")
       self.searchHistoryTable?.registerNib(UINib(nibName: "RWTSearchResultsTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "searchResults")
    }

    func bindViewModel() {
        println("binding view model")
        self.title = self.viewModel?.title

        // Bind the search text to the searchText property in the view model.
        self.searchTextField?.rac_textSignal().setKeyPath("searchText", onObject: self.viewModel)

        // An RAC command is a property on the ViewModel.
        self.searchButton?.rac_command = self.viewModel?.executeSearch

        self.viewModel?.executeSearch?.executing.setKeyPath("networkActivityIndicatorVisible", onObject: UIApplication.sharedApplication())

        self.viewModel?.executeSearch?.executing.not().setKeyPath("hidden", onObject: self.loadingIndicator)

        // hide the keyboard appropriately
        self.viewModel?.executeSearch?.executionSignals.subscribeNext({(x) -> Void in self.searchTextField?.resignFirstResponder(); return})
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        println("number of rows")
        return 3
    }

    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        let cell = self.searchHistoryTable?.cellForRowAtIndexPath(indexPath) as RWTSearchResultsTableViewCell
//        return cell.imageThumbnailView.frame.height
        return 280
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println("making cell")

        // dequeue a cell for the given indexPath
        var cell = tableView.dequeueReusableCellWithIdentifier("searchResults", forIndexPath: indexPath) as RWTSearchResultsTableViewCell

        // set the cell's text with the new string formatting
//        cell.textLabel.text = "hello"
//        cell.imageThumbnailView.frame = CGRect(x: 0, y: 0, width: 200, height: 2)

        return cell
    }
}
