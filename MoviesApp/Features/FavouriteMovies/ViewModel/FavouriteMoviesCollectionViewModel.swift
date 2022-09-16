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
    private let router: FavouriteMoviesRouter

    // MARK: - Init
    public init(moviesFetcher: FavouriteMoviesFetcher, router: FavouriteMoviesRouter) {
        self.moviesFetcher = moviesFetcher
        self.router = router
    }
}

// MARK: - Movies Fetch
extension FavouriteMoviesCollectionViewModel {
    public func fetchAllMovies() {
        moviesFetcher.fetchMovies { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(movies):
                self.handleSuccessfulMoviesFetch(with: movies)
            case .failure:
                self.handleFailureMoviesFetch()
            }
        }
    }

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

    private func handleFailureMoviesFetch() {
        noEntryMessage = "There is a problem with movies fetching. Please try later!"
    }
}

// MARK: - Navigate to details
extension FavouriteMoviesCollectionViewModel {
    public func didSelectCell(with identifier: UUID) {
        guard let presentableFavouriteMovie = findPresentableMovie(using: identifier) else { return }
        let favouriteMovie = convertFromPresentableToFavouriteMovie(presentableFavouriteMovie)
        router.navigateToDetailsScreen(movieSelected: favouriteMovie)
    }

    private func findPresentableMovie(using identifier: UUID) -> PresentableFavouriteMovieCard? {
        favouriteMovies.first { $0.id == identifier }
    }

    private func convertFromPresentableToFavouriteMovie(_ presentableFavouriteMovie: PresentableFavouriteMovieCard) -> FavouriteMovie {
        FavouriteMovie(title: presentableFavouriteMovie.title,
                       description: presentableFavouriteMovie.description,
                       image: presentableFavouriteMovie.image,
                       rating: Float(presentableFavouriteMovie.rating) ?? 0.0)
    }
}
