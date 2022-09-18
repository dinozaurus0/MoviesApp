//
//  MainComposerFavouriteMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation

extension MainComposer: FavouriteMoviesComposer {
    internal func navigateToFavouriteMovies() -> FavouritesMoviesHostingController {
        let coredataHandler = CoreDataHandler.shatedInstance()
        let moviesService = FavouriteMoviesService(fetchContext: coredataHandler.mainContext, databaseHandler: coredataHandler)

        let viewModel = FavouriteMoviesCollectionViewModel(moviesFetcher: moviesService,
                                                           moviesUpdater: moviesService,
                                                           router: DummyClass())


        let favouriteMoviesCollectionView = FavouriteMoviesCollectionView(cards: [])
        let favouriteMoviesViewController = FavouritesMoviesHostingController(rootView: favouriteMoviesCollectionView,
                                                                              viewModel: viewModel)

        return favouriteMoviesViewController
    }
}

// TODO: This is just for the compiler to allow the execution to happen. Will be converted into a propert router later on 
private final class DummyClass: FavouriteMoviesRouter {
    func navigateToSearchScreen() {}

    func navigateToDetailsScreen(movieSelected: FavouriteMovie) {}
}
