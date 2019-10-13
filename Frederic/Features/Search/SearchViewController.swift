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
    func hideLoading()
    func displayError(message: String)
    func displayEmptyState()
    func hideEmptyState()
    func goToArtistDetail()
}

class SearchViewController: UIViewController, SearchDisplayLogic {

    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    var viewModels: [Search.Artists.ViewModel] = []
    var searchController: UISearchController?
    var loadingView: LoadingView?
    var emptyView: EmptyView?
    var errorIsPresented = false

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
        setupNavigationBar()
        setupSearchBar()
        setupLoadingView()
        setupErrorView()
        setupTableView()
    }

    // MARK: Setups
    func setupNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgroundColor: self.view.backgroundColor ?? UIColor.clear,
                               tintColor: .white,
                               title: "SEARCH_NAME".localized,
                               preferredLargeTitle: true)
    }

    func setupSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.searchBar.barStyle = .blackTranslucent
        self.searchController?.searchBar.placeholder = "SEARCH_BAR".localized
        self.searchController?.searchBar.autocapitalizationType = .none
        self.searchController?.searchBar.autocorrectionType = .no
        self.searchController?.searchBar.tintColor = .white
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ArtistCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ArtistCell.reuseIdentifier)
        self.tableView.tableFooterView = self.emptyView
        self.emptyView?.startAnimation()
    }

    func setupLoadingView() {
        loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: LoadingView.height))
    }

    func setupErrorView() {
        emptyView = EmptyView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.bounds.height - 84))
    }

    // MARK: Search

    func search(_ text: String) {
        let request = Search.Artists.Request(search: text)
        interactor?.search(request: request)
    }

    // MARK: SearchDisplayLogic Functions

    func displayArtists(viewModels: [Search.Artists.ViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func displayLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView?.startLoading()
            self?.tableView.tableHeaderView = self?.loadingView
        }
    }

    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableHeaderView = nil
            self?.loadingView?.stopLoading()
        }
    }

    // Note: Will trigger a layout contraint warning
    /// There is a openradar about this issue  https://openradar.appspot.com/49289931
    func displayError(message: String) {
        guard !errorIsPresented else {
            return
        }
        errorIsPresented = true
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
            alert.view.backgroundColor = UIColor.black
            alert.view.alpha = 0.6
            alert.view.layer.cornerRadius = 15

            self?.present(alert, animated: true)

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                alert.dismiss(animated: true)
                self?.errorIsPresented = false
            }
        }
    }

    func displayEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.emptyView?.setEmptyMessage("NO_RESULTS".localized)
            self?.emptyView?.startAnimation()
            self?.tableView.tableFooterView = self?.emptyView
        }
    }

    func hideEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableFooterView = nil
            self?.emptyView?.stopAnimation()
        }
    }

    func goToArtistDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.routeToArtistDetail()
        }
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ArtistCell = tableView.dequeueReusableCell(withIdentifier: ArtistCell.reuseIdentifier, for: indexPath) as? ArtistCell else {
            return UITableViewCell()
        }

        cell.loadArtist(viewModel: viewModels[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        if self.searchController?.isActive ?? false {
            self.searchController?.isActive = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.interactor?.selectArtist(id: viewModel.id)
            }
        } else {
            self.interactor?.selectArtist(id: viewModel.id)
        }

    }
}
