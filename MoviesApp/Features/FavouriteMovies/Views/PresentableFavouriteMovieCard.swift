//
//  PresentableFavouriteMovieCard.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import Foundation

public struct PresentableFavouriteMovieCard: Identifiable {
    public let id: UUID
    public let title: String
    public let description: String
    public let image: Data
    public let rating: String

    public init(id: UUID, title: String, description: String, image: Data, rating: String) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.rating = rating
    }
}
