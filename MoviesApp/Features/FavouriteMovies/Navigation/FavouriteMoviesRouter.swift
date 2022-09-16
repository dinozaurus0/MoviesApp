//
//  FavouriteMoviesRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

public protocol FavouriteMoviesRouter {
    func navigateToSearchScreen()
    func navigateToDetailsScreen(movieSelected: FavouriteMovie)
}
