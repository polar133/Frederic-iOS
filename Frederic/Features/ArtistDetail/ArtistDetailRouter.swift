//
//  ArtistDetailRouter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

@objc protocol ArtistDetailRoutingLogic {
}

protocol ArtistDetailDataPassing {
    var dataStore: ArtistDetailDataStore? { get }
}

class ArtistDetailRouter: NSObject, ArtistDetailRoutingLogic, ArtistDetailDataPassing {
    weak var viewController: ArtistDetailViewController?
    var dataStore: ArtistDetailDataStore?
}
