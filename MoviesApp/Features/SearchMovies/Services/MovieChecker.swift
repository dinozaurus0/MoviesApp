//
//  MovieChecker.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation

internal protocol MovieChecker {
    typealias Result = Swift.Result<Bool, Error>

    func doesMovieExist(with title: String, completion: @escaping (Result) -> Void)
}
