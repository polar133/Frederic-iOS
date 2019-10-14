//
//  ArtistDetailPresenter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

protocol ArtistDetailPresentationLogic {
    func presentArtist(response: ArtistDetail.Profile.Response)
}

class ArtistDetailPresenter: ArtistDetailPresentationLogic {
    weak var viewController: ArtistDetailDisplayLogic?

    // MARK: Do something

    func presentArtist(response: ArtistDetail.Profile.Response) {
        let viewModel = ArtistDetail.Profile.ViewModel(id: response.artist.id, name: response.artist.name)
        viewController?.displayArtist(viewModel: viewModel)
    }
}
