//
//  SearchMoviesViewModel.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class SearchMoviesViewModel: ObservableObject {
    // MARK: - Properties
    private let movieFinder: MovieFinder

    // MARK: - Init
    internal init(movieFinder: MovieFinder) {
        self.movieFinder = movieFinder
    }

    // MARK: - Public Methods
    internal func searchMovie(by title: String) {
        movieFinder.find(by: title) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
}

extension SearchMoviesViewModel: SearchFieldNotifier {
    internal func didUpdateInputField(with text: String) {}
}
