//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import SwiftUI

internal struct MovieDetailsView: View {

    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel

    // MARK: - Init
    internal init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }

    // MAKR: - Body
    internal var body: some View {
        let movieDetails = viewModel.computePresentableMovieDetails()

        ScrollView {
            VStack(spacing: 20.0) {
                Image(data: movieDetails.image)?
                    .resizable()
                    .scaledToFit()
                Text(movieDetails.description)
                    .font(Font.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20.0)
                Text("IMDB rating: " + movieDetails.rating)
            }
        }
    }
}
