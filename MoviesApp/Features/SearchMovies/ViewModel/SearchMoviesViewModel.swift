//
//  SearchMoviesViewModel.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation
import SwiftUI

internal final class SearchMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published internal var noEntryMessage: String = ""
    @Published internal var presentableMovie: PresentableSearchMovieDetails?
    @Published internal var shouldShowProgressView: Bool = false

    private let movieFetcher: MovieFetcher
    private let moviePersistent: MoviePersistent
    private let movieChecker: MovieChecker
    private let router: SearchMovieRouter

    // MARK: - Init
    internal init(movieFetcher: MovieFetcher, movieChecker: MovieChecker, moviePersistent: MoviePersistent, router: SearchMovieRouter) {
        self.movieFetcher = movieFetcher
        self.movieChecker = movieChecker
        self.moviePersistent = moviePersistent
        self.router = router
    }

    // MARK: - Public Methods
    internal func loadView() {
        noEntryMessage = "Write the title of your favourite movie in the search bar to find it !"
    }

    internal func didTapCancelButton() {
        router.dimiss()
    }
}

// MARK: - Add to favourites
extension SearchMoviesViewModel {
    internal func addToFavouriteMovie() async {
        guard let presentableMovie = presentableMovie else { return }

        await showProgressView()

        let movie = createMovie(from: presentableMovie)
        do {
            try await moviePersistent.save(movie: movie)
            await handleAddToFavouriteSuccess()
        } catch {
            await handleAddToFavouriteError()
        }
    }

    private func createMovie(from presentableMovie: PresentableSearchMovieDetails) -> Movie {
        Movie(title: presentableMovie.title,
              description: presentableMovie.description,
              image: presentableMovie.image,
              rating: Float(presentableMovie.rating) ?? 0.0)
    }

    @MainActor private func handleAddToFavouriteSuccess() {
        hideProgressView()
        router.dimiss()
    }

    @MainActor private func handleAddToFavouriteError() {
        hideProgressView()
        router.presentAlert(title: "Failed to add to favourites !",
                            message: "After dismissing the alert, please try again.")
    }
}

extension SearchMoviesViewModel: SearchFieldNotifier {
    internal func didTapSearchButton(with text: String) {
        Task {
            await showProgressView()
            await executeSearchIfNeeded(title: text)
            await hideProgressView()
        }
    }

    private func executeSearchIfNeeded(title: String) async {
        do {
            let shouldExecuteSearch = try await movieChecker.doesMovieExist(with: title)
            guard !shouldExecuteSearch else {
                await showMessageForMovieInFavouriteList()
                return
            }

            let movie = try await movieFetcher.find(by: title)
            await handleSuccessfulFetch(movie: movie)
        } catch {
            await showMessageForFetchFailure()
        }
    }

    @MainActor private func showMessageForMovieInFavouriteList() {
        presentableMovie = nil
        noEntryMessage = "You have already added this movie to favourite list. Go back on the main screen to visualise its details!"
    }

    @MainActor private func handleSuccessfulFetch(movie: Movie) {
        presentableMovie = PresentableSearchMovieDetails(title: movie.title,
                                                   description: movie.description,
                                                   image: movie.image,
                                                   rating: String(movie.rating))
        noEntryMessage = ""
    }

    @MainActor private func showMessageForFetchFailure() {
        presentableMovie = nil
        noEntryMessage = "We couldn't find the movie you are looking for or you have already seen the movie. Try again!"
    }
}

// MARK: - Progress View Flag
extension SearchMoviesViewModel {
    @MainActor private func showProgressView() {
        shouldShowProgressView = true
    }

    @MainActor private func hideProgressView() {
        shouldShowProgressView = false
    }
}
