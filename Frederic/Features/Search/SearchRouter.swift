//
//  SearchRouter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

@objc protocol SearchRoutingLogic {
    func routeToArtistDetail()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?

    // MARK: Routing

    func routeToArtistDetail() {

    }

    // MARK: Navigation

    //func navigateToSomewhere(source: SearchViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: SearchDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
