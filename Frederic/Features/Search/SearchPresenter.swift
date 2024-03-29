//
//  SearchPresenter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

protocol SearchPresentationLogic {
    func presentSearchResult(response: Search.Artists.Response)
    func presentLoading()
    func dismissLoading()
    func presentErrorResult(message: String)
    func presentArtistDetail()
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    // MARK: present search result
    func presentSearchResult(response: Search.Artists.Response) {
        let viewModels: [Search.Artists.ViewModel] = response.artists.persons.compactMap { return Search.Artists.ViewModel(id: $0.id, name: $0.name) }
        if viewModels.isEmpty {
            self.viewController?.displayEmptyState()
        } else {
            self.viewController?.hideEmptyState()
        }
        self.viewController?.displayArtists(viewModels: viewModels)
    }

    func presentErrorResult(message: String) {
        self.viewController?.displayError(message: message)
    }

    func presentLoading() {
        self.viewController?.displayLoading()
    }

    func dismissLoading() {
        self.viewController?.hideLoading()
    }

    func presentArtistDetail() {
        self.viewController?.goToArtistDetail()
    }
}
