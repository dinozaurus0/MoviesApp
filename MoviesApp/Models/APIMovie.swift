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

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case description = "Plot"
        case imagePath = "Poster"
        case rating = "imdbRating"
    }

    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.imagePath = try container.decode(String.self, forKey: .imagePath)
        self.rating = try Float(container.decode(String.self, forKey: .rating)) ?? 0.0
    }
}
