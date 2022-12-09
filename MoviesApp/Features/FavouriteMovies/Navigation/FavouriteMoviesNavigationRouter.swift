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
    private let movieDetailsComposer: MovieDetailsComposer
    private let navigationController: UINavigationController

    // MARK: - Init
    internal init(searchMoviesComposer: SearchMoviesComposer, movieDetailsComposer: MovieDetailsComposer, navigationController: UINavigationController) {
        self.searchMoviesComposer = searchMoviesComposer
        self.movieDetailsComposer = movieDetailsComposer
        self.navigationController = navigationController
    }

    // MARK: - Favourite Movies Router
    internal func navigateToSearchScreen() {
        let searchViewController = searchMoviesComposer.createSearchController()
        searchViewController.modalPresentationStyle = .fullScreen
        navigationController.present(searchViewController, animated: true)
    }

    internal func navigateToDetailsScreen(selectedMovie: Movie) {
        let movieDetailsController = movieDetailsComposer.createMovieDetailsController(movie: selectedMovie)
        let navigationController = UINavigationController(rootViewController: movieDetailsController)
        self.navigationController.present(navigationController, animated: true)
    }

    @MainActor internal func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        navigationController.present(alertController, animated: true)
    }
}
