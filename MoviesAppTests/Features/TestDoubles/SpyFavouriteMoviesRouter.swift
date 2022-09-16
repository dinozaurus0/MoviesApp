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
        case navigateToSearchScreen
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func navigateToDetailsScreen(movieSelected: FavouriteMovie) {
        receivedMessages.append(.navigateToDetailsScreen(movieSelected: movieSelected))
    }

    internal func navigateToSearchScreen() {
        receivedMessages.append(.navigateToSearchScreen)
    }
}
