//
//  FavouriteMoviesNavigationRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation
import UIKit

internal final class FavouriteMoviesNavigationRouter: FavouriteMoviesRouter {

    // MARK: - Properties
    private let searchMoviesComposer: SearchMoviesComposer
    private let navigationController: UINavigationController

    // MARK: - Init
    internal init(searchMoviesComposer: SearchMoviesComposer, navigationController: UINavigationController) {
        self.searchMoviesComposer = searchMoviesComposer
        self.navigationController = navigationController
    }

    // MARK: - Favourite Movies Router
    internal func navigateToSearchScreen() {
        let searchViewController = searchMoviesComposer.navigateToSearchController() { [weak self] in
            self?.navigationController.dismiss(animated: true)
        }
        navigationController.present(searchViewController, animated: true)
    }

    internal func navigateToDetailsScreen(movieSelected: FavouriteMovie) {}
}