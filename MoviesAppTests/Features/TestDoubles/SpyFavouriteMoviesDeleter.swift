//
//  SpyFavouriteMoviesDeleter.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation
import MoviesApp

internal final class SpyFavouriteMoviesDeleter: FavouriteMoviesDeleter {

    internal enum ReceivedMessage: Equatable {
        case deleteMovie(with: UUID)
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func deleteMovie(with identifier: UUID) {
        receivedMessages.append(.deleteMovie(with: identifier))
    }
}
