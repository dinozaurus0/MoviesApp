//
//  SearchMoviesHostingController.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import SwiftUI

internal final class SearchMoviesHostingController: UIHostingController<SearchMoviesListView> {

    // MARK: - Properties
    private let viewModel: SearchMoviesViewModel
    private let searchBar: UISearchBar
    private let didTapCloseButton: () -> Void

    // MARK: - Init
    // Search bar injected
    internal init(viewModel: SearchMoviesViewModel,
                  searchBar: UISearchBar,
                  rootView: SearchMoviesListView,
                  didTapCloseButton: @escaping () -> Void) {

        self.viewModel = viewModel
        self.searchBar = searchBar
        self.didTapCloseButton = didTapCloseButton
        
        super.init(rootView: rootView)
    }

    internal required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    internal override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarItems()
    }

    private func setupNavigationBarItems() {
        navigationItem.titleView = searchBar
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseBarButton))
    }

    @objc
    private func didTapCloseBarButton() {
        didTapCloseButton()
    }
}
