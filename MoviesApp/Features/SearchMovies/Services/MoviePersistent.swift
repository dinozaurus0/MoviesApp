//
//  MoviePersistent.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation

internal protocol MoviePersistent {
    typealias Result = Swift.Result<Void, Error>

    func save(movie: Movie, completion: @escaping (Result) -> Void)
}
