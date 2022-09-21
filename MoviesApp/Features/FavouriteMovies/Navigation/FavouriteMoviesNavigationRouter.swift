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
        let searchViewController = searchMoviesComposer.navigateToSearchController()
        searchViewController.modalPresentationStyle = .fullScreen
        navigationController.present(searchViewController, animated: true)
    }

    internal func navigateToDetailsScreen(movieSelected: Movie) {}

    internal func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        navigationController.present(alertController, animated: true)
    }
}
