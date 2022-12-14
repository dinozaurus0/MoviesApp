//
//  MainComposerFavouriteMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import UIKit
import CoreData

extension MainComposer: FavouriteMoviesComposer {
    internal func createFavouriteMoviesController(navigationStack: UINavigationController) -> FavouritesMoviesHostingController {
        let moviesService = createFavouriteMoviesService()

        let router = FavouriteMoviesNavigationRouter(searchMoviesComposer: self,
                                                     movieDetailsComposer: self,
                                                     navigationController: navigationStack)

        let viewModel = FavouriteMoviesCollectionViewModel(moviesFetcher: moviesService,
                                                           moviesDeleter: moviesService,
                                                           router: router)

        let favouriteMoviesCollectionView = FavouriteMoviesCollectionView(viewModel: viewModel)
        let favouriteMoviesViewController = FavouritesMoviesHostingController(rootView: favouriteMoviesCollectionView,
                                                                              viewModel: viewModel)

        return favouriteMoviesViewController
    }

    private func createFavouriteMoviesService() -> FavouriteMoviesFetcher & FavouriteMoviesDeleter {
        let coredataHandler = CoreDataHandler.shatedInstance()
        let updateContext = coredataHandler.persistenceContainer.newBackgroundContext()

        return  FavouriteMoviesService(fetchContext: coredataHandler.mainContext,
                                       deleteContext: updateContext,
                                       databaseHandler: coredataHandler)
    }
}
