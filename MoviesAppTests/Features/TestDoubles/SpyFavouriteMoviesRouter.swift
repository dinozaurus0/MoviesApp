//
//  SpyFavouriteMoviesRouter.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

internal final class SpyFavouriteMoviesRouter: FavouriteMoviesRouter {

    internal enum ReceivedMessage: Equatable {
        case navigateToDetailsScreen(movieSelected: FavouriteMovie)
    }

    internal var receivedMessages: [ReceivedMessage] = []

    func navigateToDetailsScreen(movieSelected: FavouriteMovie) {
        receivedMessages.append(.navigateToDetailsScreen(movieSelected: movieSelected))
    }
}
