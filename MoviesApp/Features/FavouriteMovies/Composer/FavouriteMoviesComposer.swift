//
//  FavouriteMoviesComposer.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation

internal protocol FavouriteMoviesComposer {
    func navigateToFavouriteMovies() -> FavouritesMoviesHostingController
}
