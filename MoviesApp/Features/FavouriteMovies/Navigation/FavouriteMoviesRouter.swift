//
//  FavouriteMoviesRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

public protocol FavouriteMoviesRouter {
    func navigateToDetailsScreen(movieSelected: FavouriteMovie)
}
