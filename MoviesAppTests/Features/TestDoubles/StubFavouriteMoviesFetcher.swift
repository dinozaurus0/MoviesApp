//
//  StubFavouriteMoviesProviderService.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

final class StubFavouriteMoviesFetcher: FavouriteMoviesFetcher {

    private let expectedResult: FavouriteMoviesFetcher.Result

    internal init(expectedResult: FavouriteMoviesFetcher.Result) {
        self.expectedResult = expectedResult
    }

    func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        completion(expectedResult)
    }
}
