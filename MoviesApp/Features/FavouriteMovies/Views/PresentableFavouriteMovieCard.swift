//
//  PresentableFavouriteMovieCard.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import Foundation

internal struct PresentableFavouriteMovieCard: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let image: Data
    let rating: String
}
