//
//  MovieFinder.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieFinder {
    func find(by title: String) async throws -> APIMovie
}
