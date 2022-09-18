//
//  FavouritePreviewDoubles.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation

internal final class DummyFavouriteMoviesRouter: FavouriteMoviesRouter {
    func navigateToSearchScreen() {}
    func navigateToDetailsScreen(movieSelected: FavouriteMovie) {}
}

internal final class DummyFavouriteMoviesService: FavouriteMoviesFetcher, FavouriteMoviesUpdater {
    func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {}
    func dislikeMovie(with identifier: UUID) {}
}
