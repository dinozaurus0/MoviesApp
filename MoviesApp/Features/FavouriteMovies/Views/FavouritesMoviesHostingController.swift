//
//  FavouritesMoviesHostingController.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

internal final class FavouritesMoviesHostingController: UIHostingController<FavouriteMoviesCollectionView> {

    // MARK: - Properties
    private let viewModel: FavouriteMoviesCollectionViewModel

    // MARK: - Init
    internal init(rootView: FavouriteMoviesCollectionView, viewModel: FavouriteMoviesCollectionViewModel){
        self.viewModel = viewModel
        super.init(rootView: rootView)
    }

    internal required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Life Cycle
    internal override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    internal override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.loadMovies()
    }

    // MARK: - Private Methods
    private func setupNavigationBar() {
        setupNavigationTitleBar()
        setupSearchBarButton()
    }

    private func setupNavigationTitleBar() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.text = "Favourites Movies"

        navigationItem.titleView = titleLabel
    }

    private func setupSearchBarButton() {
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchBarButton))
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }

    @objc private func didTapSearchBarButton() {
        viewModel.didTapSearch()
    }
}
