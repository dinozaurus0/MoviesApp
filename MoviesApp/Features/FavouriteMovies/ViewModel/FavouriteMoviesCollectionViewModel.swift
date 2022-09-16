//
//  FavouriteMoviesCollectionViewModel.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

public final class FavouriteMoviesCollectionViewModel: ObservableObject {

    // MARK: - Properties
    @Published public var favouriteMovies: [PresentableFavouriteMovieCard] = []
    @Published public var noEntryMessage: String = ""

    private let moviesFetcher: FavouriteMoviesFetcher

    // MARK: - Init
    public init(moviesFetcher: FavouriteMoviesFetcher) {
        self.moviesFetcher = moviesFetcher
    }

    // MARK: - Public Methods
    public func fetchAllMovies() {
        moviesFetcher.fetchMovies { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(movies):
                self.handleSuccessfulMoviesFetch(with: movies)
            case .failure:
                self.noEntryMessage = "There is a problem with movies fetching. Please try later!"
            }
        }
    }

    // MARK: - Private Methods
    private func handleSuccessfulMoviesFetch(with favouriteMovies: [FavouriteMovie]) {
        if favouriteMovies.isEmpty {
            self.noEntryMessage = "No favourite movies to display!"
        }
        self.favouriteMovies = self.convertFavouriteMoviesToPresentableItems(favouriteMovies)
    }

    private func convertFavouriteMoviesToPresentableItems(_ movies: [FavouriteMovie]) -> [PresentableFavouriteMovieCard] {
        movies.map { movie in
            PresentableFavouriteMovieCard(id: UUID(), title: movie.title, description: movie.description, image: movie.image, rating: String(movie.rating) )
        }
    }
}
