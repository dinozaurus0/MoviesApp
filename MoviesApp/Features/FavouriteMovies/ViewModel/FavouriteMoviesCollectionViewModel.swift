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
    public init(moviesFetcher: FavouriteMoviesFetcher, moviesDeleter: FavouriteMoviesDeleter, router: FavouriteMoviesRouter) {
        self.moviesFetcher = moviesFetcher
        self.moviesDeleter = moviesDeleter
        self.router = router
    }
}

// MARK: - Movies Fetch & Movie Deletion
extension FavouriteMoviesCollectionViewModel {
    public func didTapDislikeCell(from identifier: UUID) async {
        let favouriteMovieTitle = mapIdentifierToTitle(identifier)

        do {
            try await moviesDeleter.remove(with: favouriteMovieTitle)
            await fetchMovies()
        } catch {
            await router.presentAlert(title: "Deletion failed!", message: "At this time, the deletion of the entry failed. Please try again later!")
        }
    }

    private func mapIdentifierToTitle(_ identifier: UUID) -> String {
        let title = favouriteMovies.first { movie in movie.id == identifier }?.title
        return title ?? ""
    }

    public func loadMovies() async {
        await fetchMovies()
    }

    private func fetchMovies() async {
        do {
            let movies = try await moviesFetcher.fetchMovies()
            await handleSuccessfulMoviesFetch(with: movies)
        } catch {
            await handleFailureMoviesFetch()
        }
    }

    @MainActor private func handleSuccessfulMoviesFetch(with favouriteMovies: [Movie]) {
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

    @MainActor private func handleFailureMoviesFetch() {
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
        router.navigateToDetailsScreen(selectedMovie: favouriteMovie)
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
