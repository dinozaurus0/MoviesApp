//
//  SpyFavouriteMoviesUpdater.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation
import MoviesApp

internal final class SpyFavouriteMoviesUpdater: FavouriteMoviesUpdater {

    internal enum ReceivedMessage: Equatable {
        case deleteMovie(with: UUID)
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func dislikeMovie(with identifier: UUID)  {
        receivedMessages.append(.deleteMovie(with: identifier))
    }
}
