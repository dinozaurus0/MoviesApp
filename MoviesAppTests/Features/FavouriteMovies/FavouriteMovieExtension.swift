//
//  FavouriteMovieExtension.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

extension FavouriteMovie: Equatable {
    public static func == (lhs: FavouriteMovie, rhs: FavouriteMovie) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.image == rhs.image && lhs.rating == rhs.rating
    }
}
