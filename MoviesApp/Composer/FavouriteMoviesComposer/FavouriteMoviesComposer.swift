//
//  FavouriteMoviesComposer.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import UIKit

internal protocol FavouriteMoviesComposer {
    func createFavouriteMoviesController(navigationStack: UINavigationController) -> FavouritesMoviesHostingController
}
