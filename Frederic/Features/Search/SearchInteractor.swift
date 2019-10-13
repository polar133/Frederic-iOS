//
//  SearchInteractor.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

protocol SearchBusinessLogic {
    func search(request: Search.Artists.Request)
    func selectArtist(id: Int)
}

protocol SearchDataStore {
    var artist: Artist? { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    var artist: Artist?
    var artists: ArtistsResponse?

    init(worker: SearchWorker = SearchWorker()) {
        self.worker = worker
    }

    // MARK: Get Artists
    func search(request: Search.Artists.Request) {
        guard request.search.count > 2 else {
            return
        }
        self.presenter?.presentLoading()
        worker?.doSearch(search: request.search, callback: { [weak self] result in
            self?.presenter?.dismissLoading()
            switch result {
            case .success(let response):
                self?.artists = response
                self?.presenter?.presentSearchResult(response: response)
            case .failure(let error):
                self?.presenter?.presentErrorResult(message: error.localizedDescription)
            }
        })
    }

    func selectArtist(id: Int) {
        guard let artist = self.artists?.artists.persons.first(where: { $0.id == id }) else {
            return
        }
        self.artist = artist
        self.presenter?.presentArtistDetail()
    }
}
