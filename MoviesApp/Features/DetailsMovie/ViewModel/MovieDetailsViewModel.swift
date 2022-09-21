//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import Foundation

internal struct MovieDetailsViewModel {

    // MARK: - Properties
    private let movie: Movie

    // MARK: - Init
    internal init(movie: Movie) {
        self.movie = movie
    }

    // MAKR: - Public Methods
    internal func computeTitle() -> String {
        return movie.title
    }

    internal func computePresentableMovieDetails() -> PresentableMovieDetails {
        return PresentableMovieDetails(description: movie.description, image: movie.image, rating: String(movie.rating))
    }
}
