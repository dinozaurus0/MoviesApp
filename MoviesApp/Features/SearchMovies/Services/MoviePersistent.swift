//
//  MoviePersistent.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation

internal protocol MoviePersistent {
    func save(movie: Movie) async throws
}
