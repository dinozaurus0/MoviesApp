//
//  MovieDetailsHostingController.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import SwiftUI

internal final class MovieDetailsHostingController: UIHostingController<MovieDetailsView> {

    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel

    // MARK: - Init
    internal init(viewModel: MovieDetailsViewModel, rootView: MovieDetailsView) {
        self.viewModel = viewModel
        super.init(rootView: rootView)
    }

    internal required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    internal override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationTitleBar()
    }

    // MARK: - Private Methods
    private func setupNavigationTitleBar() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.text = viewModel.computeScreenTitle()

        navigationItem.titleView = titleLabel
    }
}
    
