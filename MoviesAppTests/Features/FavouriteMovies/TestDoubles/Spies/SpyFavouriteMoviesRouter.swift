//
//  SpyFavouriteMoviesRouter.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

internal final class SpyFavouriteMoviesRouter: FavouriteMoviesRouter {

    internal enum ReceivedMessage: Equatable {
        case navigateToDetailsScreen(movieSelected: Movie)
        case navigateToSearchScreen
        case presentAlert(title: String, message: String)
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func navigateToDetailsScreen(selectedMovie: Movie) {
        receivedMessages.append(.navigateToDetailsScreen(movieSelected: selectedMovie))
    }

    internal func navigateToSearchScreen() {
        receivedMessages.append(.navigateToSearchScreen)
    }

    internal func presentAlert(title: String, message: String) {
        receivedMessages.append(.presentAlert(title: title, message: message))
    }
}
