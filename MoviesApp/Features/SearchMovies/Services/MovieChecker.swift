//
//  MovieChecker.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation

internal protocol MovieChecker {
    func doesMovieExist(with title: String) async throws -> Bool
}
