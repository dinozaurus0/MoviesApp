//
//  APIMovie.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal struct APIMovie: Decodable {
    let title: String
    let description: String
    let imagePath: String
    let rating: Float
}
