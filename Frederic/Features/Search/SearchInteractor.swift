//
//  SearchInteractor.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func search(request: Search.Artists.Request)
}

protocol SearchDataStore {
    var artist: Artist? { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    var artist: Artist?

    // MARK: Get Artists
    func search(request: Search.Artists.Request) {
        worker = SearchWorker()
        worker?.doSearch(search: request.search, callback: { [weak self] result in
            //TODO: Implement
        })
    }
}
