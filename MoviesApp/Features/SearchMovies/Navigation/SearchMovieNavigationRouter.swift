//
//  SearchMovieNavigationRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import UIKit

internal final class SearchMovieNavigationRouter: SearchMovieRouter {

    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Init
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - SearchMovieRouter
    internal func dimiss() {
        navigationController.dismiss(animated: true)
    }
}
