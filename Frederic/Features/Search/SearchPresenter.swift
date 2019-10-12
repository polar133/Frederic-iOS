//
//  SearchPresenter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentSearchResult(response: Search.Artists.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    // MARK: present search result

    func presentSearchResult(response: Search.Artists.Response) {
        let viewModel = Search.Artists.ViewModel()
        viewController?.displayArtists(viewModels: [viewModel])
    }
}
