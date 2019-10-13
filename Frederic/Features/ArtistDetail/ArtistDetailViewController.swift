//
//  ArtistDetailViewController.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import UIKit

protocol ArtistDetailDisplayLogic: class {
    func displayArtist(viewModel: ArtistDetail.Profile.ViewModel)
}

class ArtistDetailViewController: UIViewController, ArtistDetailDisplayLogic {
    var interactor: ArtistDetailBusinessLogic?
    var router: (NSObjectProtocol & ArtistDetailRoutingLogic & ArtistDetailDataPassing)?

    // MARK: Object lifecycle
    @IBOutlet private weak var artistImage: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!

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
        let router = ArtistDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtist()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: Setups
    func setupNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgroundColor: self.view.backgroundColor ?? UIColor.clear,
                               tintColor: .white,
                               title: "ARTIST_DETAIL".localized,
                               preferredLargeTitle: true)
    }

    func loadArtist() {
        let request = ArtistDetail.Profile.Request()
        interactor?.getArtist(request: request)
    }

    func displayArtist(viewModel: ArtistDetail.Profile.ViewModel) {
        artistNameLabel.text = viewModel.name
        guard let url = FredericAPI.imageURL(id: viewModel.id) else {
            return
        }
        self.artistImage.load(url: url)
    }
}
