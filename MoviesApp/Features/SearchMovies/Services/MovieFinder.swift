//
//  MovieFinder.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieFinder {
    typealias Result = Swift.Result<Movie, Error>

    func find(by title: String, completion: @escaping (Result) -> Void)
}
