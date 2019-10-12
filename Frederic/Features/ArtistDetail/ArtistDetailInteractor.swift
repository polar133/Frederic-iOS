//
//  ArtistDetailInteractor.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol ArtistDetailBusinessLogic {
    func doSomething(request: ArtistDetail.Something.Request)
}

protocol ArtistDetailDataStore {
    var artist: Artist? { get set }
}

class ArtistDetailInteractor: ArtistDetailBusinessLogic, ArtistDetailDataStore {
    var presenter: ArtistDetailPresentationLogic?
    var artist: Artist?

    // MARK: Do something

    func doSomething(request: ArtistDetail.Something.Request) {
        let response = ArtistDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
