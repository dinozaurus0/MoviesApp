//
//  FavouriteMoviesUpdater.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

internal protocol FavouriteMoviesDeleter {
    typealias Result = Swift.Result<Void, Error>

    func remove(with title: String, completion: @escaping (Result) -> Void)
}
