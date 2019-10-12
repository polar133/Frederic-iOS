//
//  SearchViewController.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
  func displaySomething(viewModel: Search.Artists.ViewModel)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
  var interactor: SearchBusinessLogic?
  var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?

  // MARK: Object lifecycle

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup

  private func setup() {
    let viewController = self
    let interactor = SearchInteractor()
    let presenter = SearchPresenter()
    let router = SearchRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }

  // MARK: Routing

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }

  // MARK: View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomething()
  }

  // MARK: Do something

  //@IBOutlet weak var nameTextField: UITextField!

  func doSomething() {
    let request = Search.Artists.Request()
    interactor?.doSomething(request: request)
  }

  func displaySomething(viewModel: Search.Artists.ViewModel) {
    //nameTextField.text = viewModel.name
  }
}
