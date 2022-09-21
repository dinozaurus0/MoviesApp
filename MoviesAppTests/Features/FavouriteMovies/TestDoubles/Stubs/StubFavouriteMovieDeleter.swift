//
//  StubFavouriteMovieDeleter.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import MoviesApp

internal final class StubFavouriteMovieDeleter: FavouriteMoviesDeleter {

    private let expectedResult: FavouriteMoviesDeleter.Result

    internal init(expectedResult: FavouriteMoviesDeleter.Result) {
        self.expectedResult = expectedResult
    }

    internal func remove(with title: String, completion: @escaping (FavouriteMoviesDeleter.Result) -> Void) {
        completion(expectedResult)
    }
}
