//
//  FavouritePreviewDoubles.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation

internal final class DummyFavouriteMoviesRouter: FavouriteMoviesRouter {
    internal func navigateToSearchScreen() {}
    internal func navigateToDetailsScreen(selectedMovie: Movie) {}
    internal func presentAlert(title: String, message: String) {}
}

internal final class DummyFavouriteMoviesService: FavouriteMoviesFetcher, FavouriteMoviesDeleter {
    internal func remove(with title: String) async throws {}
    internal func fetchMovies() async throws -> [Movie] { return [] }
}
