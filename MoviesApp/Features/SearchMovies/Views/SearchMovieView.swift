//
//  SearchMovieView.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import SwiftUI

internal struct SearchMovieView: View {

    // MARK: - Properties
    @ObservedObject private var viewModel: SearchMoviesViewModel

    // MARK: - Init
    internal init(viewModel: SearchMoviesViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    internal var body: some View {
        ZStack {
            noEntryMessage
            movieDetails
            showProgressViewIfNeeded()
        }
    }

    private var movieDetails: some View {
        viewModel.presentableMovie.map { movie in
            ScrollView {
                VStack {
                    Image(data: movie.image)
                    detailsStack(movie: movie)
                }
            }
        }
    }

    private func detailsStack(movie: PresentableMovieDetails) -> some View {
        VStack(spacing: 10.0) {
            Text(movie.title)
                .font(Font.title)
                .fontWeight(.bold)
            Text(movie.description)
                .font(Font.body)
            Text(movie.rating)
            Button {
                // di Tap Button
            } label: {
                Text("Add To Favourite List")
                    .font(Font.body)
            }

        }
    }

    private var noEntryMessage: some View {
        Text(viewModel.noEntryMessage)
            .font(Font.body)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20.0)
    }

    private func showProgressViewIfNeeded() -> some View {
        Group {
            if viewModel.shouldShowProgressView {
                ProgressView()
            } else {
                EmptyView()
            }
        }
    }
}
