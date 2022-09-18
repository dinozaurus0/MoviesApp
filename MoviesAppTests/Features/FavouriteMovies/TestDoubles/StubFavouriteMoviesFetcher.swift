//
//  StubFavouriteMoviesProviderService.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

internal final class StubFavouriteMoviesFetcher: FavouriteMoviesFetcher {

    private let expectedResult: FavouriteMoviesFetcher.Result

    internal init(expectedResult: FavouriteMoviesFetcher.Result) {
        self.expectedResult = expectedResult
    }

    internal func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        completion(expectedResult)
    }
}
