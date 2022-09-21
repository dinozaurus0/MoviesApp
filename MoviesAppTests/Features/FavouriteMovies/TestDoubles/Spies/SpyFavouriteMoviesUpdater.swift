//
//  SpyFavouriteMoviesUpdater.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation
import MoviesApp

internal final class SpyFavouriteMoviesDeleter: FavouriteMoviesDeleter {

    internal enum ReceivedMessage: Equatable {
        case deleteMovie(with: String)
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func remove(with title: String, completion: @escaping (FavouriteMoviesDeleter.Result) -> Void) {
        receivedMessages.append(.deleteMovie(with: title))
    }
}
