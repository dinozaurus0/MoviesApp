//
//  FavouriteMoviesRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

internal protocol FavouriteMoviesRouter {
    func navigateToSearchScreen()
    func navigateToDetailsScreen(movieSelected: Movie)
    func presentAlert(title: String, message: String)
}

