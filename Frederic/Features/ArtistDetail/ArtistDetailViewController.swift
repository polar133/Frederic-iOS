//
//  ArtistDetailViewController.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import UIKit

protocol ArtistDetailDisplayLogic: class {
    func displaySomething(viewModel: ArtistDetail.Something.ViewModel)
}

class ArtistDetailViewController: UIViewController, ArtistDetailDisplayLogic {
    var interactor: ArtistDetailBusinessLogic?

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
        let interactor = ArtistDetailInteractor()
        let presenter = ArtistDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = ArtistDetail.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: ArtistDetail.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
