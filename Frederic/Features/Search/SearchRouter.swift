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
        guard let dataStore = self.dataStore, let viewController = self.viewController else {
            return
        }
        let artistViewController = ArtistDetailViewController()
        var artistDataStore = artistViewController.router?.dataStore
        passDataToArtistDetail(source: dataStore, destination: &artistDataStore)
        navigateToArtistDetail(source: viewController, destination: artistViewController)
    }

    // MARK: Navigation

    func navigateToArtistDetail(source: SearchViewController, destination: ArtistDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: Passing data

    func passDataToArtistDetail(source: SearchDataStore, destination: inout ArtistDetailDataStore?) {
        destination?.artist = source.artist
    }
}
