//
//  ArtistDetailInteractor.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

protocol ArtistDetailBusinessLogic {
    func getArtist(request: ArtistDetail.Profile.Request)
}

protocol ArtistDetailDataStore {
    var artist: Artist? { get set }
}

class ArtistDetailInteractor: ArtistDetailBusinessLogic, ArtistDetailDataStore {
    var presenter: ArtistDetailPresentationLogic?
    var artist: Artist?

    // MARK: Do something

    func getArtist(request: ArtistDetail.Profile.Request) {
        guard let artist = self.artist else {
            return
        }
        let response = ArtistDetail.Profile.Response(artist: artist)
        presenter?.presentArtist(response: response)
    }
}
