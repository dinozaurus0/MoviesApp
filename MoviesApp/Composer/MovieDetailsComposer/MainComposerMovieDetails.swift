//
//  MainComposerMovieDetails.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import Foundation

extension MainComposer: MovieDetailsComposer {
    internal func createMovieDetailsController(movie: Movie) -> MovieDetailsHostingController {

        return MovieDetailsHostingController(rootView: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie)))
    }
}
