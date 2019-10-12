//
//  SearchPresenter.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentSomething(response: Search.Something.Response)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?

  // MARK: Do something

  func presentSomething(response: Search.Something.Response) {
    let viewModel = Search.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
