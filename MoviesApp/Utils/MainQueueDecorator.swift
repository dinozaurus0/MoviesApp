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

extension MainQueueDecorator: MovieFetcher where DecorateeType: MovieFetcher {
    internal func find(by title: String, completion: @escaping (MovieFetcher.Result) -> Void) {
        decoratee.find(by: title) { [weak self] result in
            self?.executeOnMainQueue { completion(result) }
        }
    }
}