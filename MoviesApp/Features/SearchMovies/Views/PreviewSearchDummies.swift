//
//  PreviewSearchDummies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class DummyMovieFetcher: MovieFetcher {
    internal init() {}

    internal func find(by title: String) async throws -> Movie {
        return Movie(title: "", description: "", image: Data(), rating: 1.0)
    }
}

internal final class DummySearchMovieService: MoviePersistent, MovieChecker {
    internal init() {}

    internal func save(movie: Movie) async throws {}
    internal func doesMovieExist(with title: String) async throws -> Bool {
        return true
    }
}

internal final class DummySearchMovieNavigationRouter: SearchMovieRouter {

    internal init() {}

    func dimiss() {}
    func presentAlert(title: String, message: String) {}
}
