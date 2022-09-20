//
//  PreviewSearchDummies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class DummyMovieFetcher: MovieFetcher {
    internal init() {}

    internal func find(by title: String, completion: @escaping (MovieFetcher.Result) -> Void) {}
}

internal final class DummySearchMovieService: MoviePersistent {
    internal init() {}

    internal func save(movie: Movie, completion: @escaping (MoviePersistent.Result) -> Void) {}
}

internal final class DummySearchMovieNavigationRouter: SearchMovieRouter {
    internal init() {}

    func dimiss() {}
}