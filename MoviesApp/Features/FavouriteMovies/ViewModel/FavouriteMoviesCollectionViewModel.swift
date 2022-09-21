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
    private let moviesDeleter: FavouriteMoviesDeleter
    private let router: FavouriteMoviesRouter

    // MARK: - Init
    internal init(moviesFetcher: FavouriteMoviesFetcher, moviesDeleter: FavouriteMoviesDeleter, router: FavouriteMoviesRouter) {
        self.moviesFetcher = moviesFetcher
        self.moviesDeleter = moviesDeleter
        self.router = router
    }
}

// MARK: - Movies Fetch & Movie Deletion
extension FavouriteMoviesCollectionViewModel {
    public func didTapDislikeCell(from identifier: UUID) {
        let favouriteMovieTitle = mapIdentifierToTitle(identifier)

        moviesDeleter.remove(with: favouriteMovieTitle) { [weak self] result in
            switch result {
            case .success:
                self?.fetchMovies()
            case .failure:
                self?.router.presentAlert(title: "Deletion failed!", message: "At this time, the deletion of the entry failed. Please try again later!")
            }
        }
    }

    private func mapIdentifierToTitle(_ identifier: UUID) -> String {
        let title = favouriteMovies.first { movie in movie.id == identifier }?.title
        return title ?? ""
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

    private func handleSuccessfulMoviesFetch(with favouriteMovies: [Movie]) {
        if favouriteMovies.isEmpty {
            noEntryMessage = "No favourite movies to display!"
        } else {
            noEntryMessage = ""
        }
        
        self.favouriteMovies = convertFavouriteMoviesToPresentableItems(favouriteMovies)
    }

    private func convertFavouriteMoviesToPresentableItems(_ movies: [Movie]) -> [PresentableFavouriteMovieCard] {
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

    private func convertFromPresentableToFavouriteMovie(_ presentableFavouriteMovie: PresentableFavouriteMovieCard) -> Movie {
        Movie(title: presentableFavouriteMovie.title,
              description: presentableFavouriteMovie.description,
              image: presentableFavouriteMovie.image,
              rating: Float(presentableFavouriteMovie.rating) ?? 0.0)
    }
}

// handle when delete fails
// update ui cell
// navigate to
