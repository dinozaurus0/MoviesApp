//
//  MovieDetailsComposer.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import SwiftUI

internal protocol MovieDetailsComposer {
    func createMovieDetailsController(movie: Movie) -> MovieDetailsHostingController
}
