//
//  SearchMoviesViewModel.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class SearchMoviesViewModel: ObservableObject {
    // MARK: - Properties
    @Published internal var noEntryMessage: String = ""
    @Published internal var presentableMovie: PresentableMovieDetails?
    @Published internal var shouldShowProgressView: Bool = false

    private let movieFetcher: MovieFetcher
    private let moviePersistent: MoviePersistent
    private let router: SearchMovieRouter

    // MARK: - Init
    internal init(movieFetcher: MovieFetcher, moviePersistent: MoviePersistent, router: SearchMovieRouter) {
        self.movieFetcher = movieFetcher
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

    internal func addToFavouriteMovie() {
        guard let presentableMovie = presentableMovie else { return }

        let movie = createMovie(from: presentableMovie)
        moviePersistent.save(movie: movie) { [weak self] result in
            self?.router.dimiss()
        }
    }

    private func createMovie(from presentableMovie: PresentableMovieDetails) -> Movie {
        Movie(title: presentableMovie.title,
              description: presentableMovie.description,
              image: presentableMovie.image,
              rating: Float(presentableMovie.rating) ?? 0.0)
    }
}

extension SearchMoviesViewModel: SearchFieldNotifier {
    internal func didUpdateInputField(with text: String) {
        showProgressView()
        guard isIntroducedTextValid(text) else { return }

        // Before we make the request, check if the user has seen the movie. If so, don;t display it
        searchMovie(by: text)
    }

    private func showProgressView() {
        shouldShowProgressView = true
    }

    private func hideProgressView() {
        shouldShowProgressView = false
    }

    private func isIntroducedTextValid(_ text: String) -> Bool {
        !text.isEmpty
    }

    private func searchMovie(by title: String) {
        movieFetcher.find(by: title) { [weak self] result in
            guard let self = self else { return }

            self.handleMovieFinderResult(result)
            self.hideProgressView()
        }
    }

    private func handleMovieFinderResult(_ result: MovieFetcher.Result) {
        switch result {
        case .success(let movie):
            self.handleSuccessfulFetch(movie: movie)
        case .failure:
            self.showMessageForNetworkFailure()
        }

    }

    private func handleSuccessfulFetch(movie: Movie) {
        presentableMovie = PresentableMovieDetails(title: movie.title,
                                                   description: movie.description,
                                                   image: movie.image,
                                                   rating: String(movie.rating))
        noEntryMessage = ""
    }

    private func showMessageForNetworkFailure() {
        presentableMovie = nil
        noEntryMessage = "We couldn't find the movie you are looking for or you have already seen the movie. Try again!"
    }
}
