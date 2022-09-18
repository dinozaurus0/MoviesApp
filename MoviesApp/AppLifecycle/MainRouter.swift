//
//  MainRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import UIKit

internal final class MainRouter {
    internal func startApp(window: UIWindow) {
        let favouriteMoviesCollectionView = FavouriteMoviesCollectionView(cards: [])
        let initialViewController = FavouritesMoviesHostingController(rootView: favouriteMoviesCollectionView, viewModel: )

        let navigationController = UINavigationController(rootViewController: initialViewController)

        window.rootViewController = navigationController

        window.makeKeyAndVisible()
    }
}
