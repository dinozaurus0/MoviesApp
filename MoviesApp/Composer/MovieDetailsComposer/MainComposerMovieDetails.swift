//
//  MainComposerMovieDetails.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import Foundation

extension MainComposer: MovieDetailsComposer {
    internal func createMovieDetailsController(movie: Movie) -> MovieDetailsHostingController {
        let viewModel = MovieDetailsViewModel(movie: movie)

        let movieDetailsView = MovieDetailsView(viewModel: viewModel)
        return MovieDetailsHostingController(viewModel: viewModel, rootView: movieDetailsView)
    }
}
