//
//  MovieFetcher.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieFetcher {
    func find(by title: String) async throws -> Movie
}
