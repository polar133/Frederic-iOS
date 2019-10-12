//
//  SearchViewController.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
    func displayArtists(viewModels: [Search.Artists.ViewModel])
    func displayLoading()
    func displayError()
    func displayEmptyState()
}

class SearchViewController: UIViewController, SearchDisplayLogic {

    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    var viewModels: [Search.Artists.ViewModel] = []

    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!

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

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Frederic"
        setupNavigationBar()
        setupTableView()
    }

    // MARK: Setups
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search for artists"
        self.navigationItem.searchController = search
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: Search

    func search(_ text: String) {
        let request = Search.Artists.Request(search: text)
        interactor?.search(request: request)
    }

    // MARK: SearchDisplayLogic Functions

    func displayLoading() {

    }

    func displayArtists(viewModels: [Search.Artists.ViewModel]) {
        self.viewModels = viewModels
        self.tableView.reloadData()
    }

    func displayError() {
    }

    func displayEmptyState() {
    }
}

// MARK: UISearchViewController functions
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        self.search(text)
    }

}
// MARK: UITableView functions
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
