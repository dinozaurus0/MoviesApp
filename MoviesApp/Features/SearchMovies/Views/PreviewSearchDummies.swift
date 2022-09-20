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
