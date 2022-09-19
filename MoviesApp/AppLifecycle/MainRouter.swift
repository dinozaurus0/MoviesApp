//
//  MainRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import UIKit

internal final class MainRouter {

    // MARK: - Properties
    private let favouriteMoviesComposer: FavouriteMoviesComposer

    // MARK: - Init
    internal init(favouriteMoviesComposer: FavouriteMoviesComposer) {
        self.favouriteMoviesComposer = favouriteMoviesComposer
    }

    // MARK: - Start app
    internal func startApp(window: UIWindow) {
        let navigationController = UINavigationController()
        let initialViewController = favouriteMoviesComposer.navigateToFavouriteMovies(navigationStack: navigationController)
        navigationController.pushViewController(initialViewController, animated: false)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
