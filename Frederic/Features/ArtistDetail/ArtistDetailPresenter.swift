//
//  ArtistDetailPresenter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol ArtistDetailPresentationLogic {
    func presentSomething(response: ArtistDetail.Something.Response)
}

class ArtistDetailPresenter: ArtistDetailPresentationLogic {
    weak var viewController: ArtistDetailDisplayLogic?

    // MARK: Do something

    func presentSomething(response: ArtistDetail.Something.Response) {
        let viewModel = ArtistDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
