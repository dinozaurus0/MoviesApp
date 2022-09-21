//
//  PresentableFavouriteMovieCard.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import Foundation

internal struct PresentableFavouriteMovieCard: Identifiable {
    internal let id: UUID
    internal let title: String
    internal let description: String
    internal let image: Data
    internal let rating: String

    internal init(id: UUID, title: String, description: String, image: Data, rating: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.rating = rating
    }
}
