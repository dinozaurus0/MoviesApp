//
//  FavouriteMovie.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

public struct FavouriteMovie {
    public let title: String
    public let description: String
    public let image: Data
    public let rating: Float

    public init(title: String, description: String, image: Data, rating: Float) {
        self.title = title
        self.description = description
        self.image = image
        self.rating = rating
    }
}
