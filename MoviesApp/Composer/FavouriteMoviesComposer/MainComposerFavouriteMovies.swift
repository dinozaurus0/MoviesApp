//
//  MainComposerFavouriteMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation
import UIKit
import CoreData

extension MainComposer: FavouriteMoviesComposer {
    internal func navigateToFavouriteMovies(navigationStack: UINavigationController) -> FavouritesMoviesHostingController {
        let coredataHandler = CoreDataHandler.shatedInstance()
        let updateContext = coredataHandler.persistenceContainer.newBackgroundContext()
        let moviesService = FavouriteMoviesService(fetchContext: coredataHandler.mainContext,
                                                   deleteContext: updateContext,
                                                   databaseHandler: coredataHandler)

        let router = FavouriteMoviesNavigationRouter(searchMoviesComposer: self,
                                                     navigationController: navigationStack)

        let viewModel = FavouriteMoviesCollectionViewModel(moviesFetcher: moviesService,
                                                           moviesDeleter: moviesService,
                                                           router: router)

        let favouriteMoviesCollectionView = FavouriteMoviesCollectionView(viewModel: viewModel)
        let favouriteMoviesViewController = FavouritesMoviesHostingController(rootView: favouriteMoviesCollectionView,
                                                                              viewModel: viewModel)

        return favouriteMoviesViewController
    }
}
