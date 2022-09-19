//
//  FavouriteMoviesUpdater.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

public protocol FavouriteMoviesUpdater {
    typealias Result = Swift.Result<Void, Error>

    func dislikeMovie(with title: String, completion: @escaping (Result) -> Void)
}
