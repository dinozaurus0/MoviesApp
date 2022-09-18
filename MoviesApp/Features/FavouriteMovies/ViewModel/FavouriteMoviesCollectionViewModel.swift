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
    private let moviesUpdater: FavouriteMoviesUpdater
    private let router: FavouriteMoviesRouter

    // MARK: - Init
    public init(moviesFetcher: FavouriteMoviesFetcher, moviesUpdater: FavouriteMoviesUpdater, router: FavouriteMoviesRouter) {
        self.moviesFetcher = moviesFetcher
        self.moviesUpdater = moviesUpdater
        self.router = router
    }
}

// MARK: - Movies Fetch & Movie Deletion
extension FavouriteMoviesCollectionViewModel {
    public func didTapDislikeCell(from identifier: UUID) {
        moviesUpdater.dislikeMovie(with: identifier)
        fetchMovies()
    }

    public func loadMovies() {
        fetchMovies()
    }

    private func fetchMovies() {
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
            noEntryMessage = "No favourite movies to display!"
        }
        self.favouriteMovies = convertFavouriteMoviesToPresentableItems(favouriteMovies)
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

// MARK: - Navigate to details & search screen
extension FavouriteMoviesCollectionViewModel {
    public func didTapSearch() {
        router.navigateToSearchScreen()
    }

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
