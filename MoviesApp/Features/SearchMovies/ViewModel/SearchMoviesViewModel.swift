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
    internal func addToFavouriteMovie() {
        guard let presentableMovie = presentableMovie else { return }

        showProgressView()

        let movie = createMovie(from: presentableMovie)
        moviePersistent.save(movie: movie) { [weak self] result in
            guard let self = self else { return }

            self.hideProgressView()
            self.handlePersistentResult(result)
        }
    }

    private func createMovie(from presentableMovie: PresentableSearchMovieDetails) -> Movie {
        Movie(title: presentableMovie.title,
              description: presentableMovie.description,
              image: presentableMovie.image,
              rating: Float(presentableMovie.rating) ?? 0.0)
    }

    private func handlePersistentResult(_ result: MoviePersistent.Result) {
        switch result {
        case .success:
            router.dimiss()
        case .failure:
            router.presentAlert(title: "Failed to add to favourites !",
                                message: "After dismissing the alert, please try again.")
        }
    }
}

extension SearchMoviesViewModel: SearchFieldNotifier {
    internal func didTapSearchButton(with text: String) {
        showProgressView()

        executeSearchIfNeeded(text: text) { [weak self] in
            self?.hideProgressView()
        }
    }

    private func executeSearchIfNeeded(text: String, completion: @escaping () -> Void) {
        checkMovieExistance(text: text, completion: completion)
    }

    private func checkMovieExistance(text: String, completion: @escaping () -> Void) {
        movieChecker.doesMovieExist(with: text) { [weak self] result in
            self?.handleExistanceCheckResult(result, title: text, completion: completion)
        }
    }

    private func handleExistanceCheckResult(_ result: MovieChecker.Result, title: String, completion: @escaping () -> Void) {
        switch result {
        case .success(let isMovieInFavouriteList):
            startSearchMovieIfNeeded(isMovieInFavouriteList, title: title, completion: completion)
        case .failure:
            showMessageForFetchFailure()
            completion()
        }
    }

    private func startSearchMovieIfNeeded(_ isMovieInFavouriteList: Bool, title: String, completion: @escaping () -> Void) {
        guard !isMovieInFavouriteList else {
            showMessageForMovieInFavouriteList()
            completion()
            return
        }

        searchMovie(by: title, completion: completion)
    }

    private func showMessageForMovieInFavouriteList() {
        presentableMovie = nil
        noEntryMessage = "You have already added this movie to favourite list. Go back on the main screen to visualise its details!"
    }

    private func searchMovie(by title: String, completion: @escaping () -> Void) {
        movieFetcher.find(by: title) { [weak self] result in
            guard let self = self else { return }

            self.handleMovieFinderResult(result)
            completion()
        }
    }

    private func handleMovieFinderResult(_ result: MovieFetcher.Result) {
        switch result {
        case .success(let movie):
            self.handleSuccessfulFetch(movie: movie)
        case .failure:
            self.showMessageForFetchFailure()
        }
    }

    private func handleSuccessfulFetch(movie: Movie) {
        presentableMovie = PresentableSearchMovieDetails(title: movie.title,
                                                   description: movie.description,
                                                   image: movie.image,
                                                   rating: String(movie.rating))
        noEntryMessage = ""
    }

    private func showMessageForFetchFailure() {
        presentableMovie = nil
        noEntryMessage = "We couldn't find the movie you are looking for or you have already seen the movie. Try again!"
    }
}

// MARK: - Progress View Flag
extension SearchMoviesViewModel {
    private func showProgressView() {
        shouldShowProgressView = true
    }

    private func hideProgressView() {
        shouldShowProgressView = false
    }
}
