//
//  MainQueueDecorator.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class MainQueueDecorator<DecorateeType> {
    // MARK: - Properties
    private let decoratee: DecorateeType

    // MARK: - Init
    internal init(decoratee: DecorateeType) {
        self.decoratee = decoratee
    }

    internal func executeOnMainQueue(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}


extension MainQueueDecorator: FavouriteMoviesFetcher where DecorateeType: FavouriteMoviesFetcher {
    internal func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        decoratee.fetchMovies { [weak self] result in
            self?.executeOnMainQueue { completion(result) }
        }
    }
}

extension MainQueueDecorator: FavouriteMoviesDeleter where DecorateeType: FavouriteMoviesDeleter {
    func remove(with title: String, completion: @escaping (FavouriteMoviesDeleter.Result) -> Void) {
        decoratee.remove(with: title) { [weak self] result in
            self?.executeOnMainQueue { completion(result) }
        }
    }
}
