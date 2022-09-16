//
//  SpyFavouriteMoviesFetcher.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import MoviesApp

internal final class SpyFavouriteMoviesFetcher: FavouriteMoviesFetcher {
    internal enum ReceivedMessage: Equatable {
        case fetchFavouritesMovies
    }

    internal var receivedMessages: [ReceivedMessage] = []

    internal func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        receivedMessages.append(ReceivedMessage.fetchFavouritesMovies)
    }
}

