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
                VStack(spacing: 30.0) {
                    Image(data: movie.image)?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    detailsStack(movie: movie)
                    addToFavouriteButton
                }
            }
        }
    }

    private func detailsStack(movie: PresentableSearchMovieDetails) -> some View {
        VStack(spacing: 20.0) {
            textStack(movie: movie)
            ratingView(movie: movie)
        }
    }

    private func textStack(movie: PresentableSearchMovieDetails) -> some View {
        VStack(spacing: 20.0) {
            Text(movie.title)
                .font(Font.title)
                .fontWeight(.bold)
            Text(movie.description)
                .font(Font.body)

        }
        .multilineTextAlignment(.leading)
        .padding(.horizontal, 15.0)
    }

    private func ratingView(movie: PresentableSearchMovieDetails) -> some View {
        HStack {
            Spacer()
            Text("IMDB Movie Rating: ")
                .font(Font.body)
                .fontWeight(.bold)
            Text(movie.rating)
                .font(Font.body)
                .padding(.trailing, 20.0)
        }.padding(.horizontal, 20.0)
    }

    private var addToFavouriteButton: some View {
        Button { [weak viewModel] in
            viewModel?.addToFavouriteMovie()
        } label: {
            Text("Add To Favourite List")
                .font(Font.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20.0)
        .padding(.vertical, 10.0)
        .background(Color.gray)
        .border(.gray)
        .cornerRadius(10.0)
        .padding(.top, 20.0)
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

internal struct SearchMovieView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchMoviesViewModel(movieFetcher: DummyMovieFetcher(),
                                              movieChecker: DummySearchMovieService(),
                                              moviePersistent: DummySearchMovieService(),
                                              router: DummySearchMovieNavigationRouter())
        viewModel.presentableMovie = presentableMovie
        return SearchMovieView(viewModel: viewModel)
    }

    private static var presentableMovie =
    PresentableSearchMovieDetails(title: "Game of Thrones",
                            description: "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea.",
                            image: loadImageData(from: loadImagePath(for: "GOTImage", type: "jpeg")),
                            rating: "9.1")
}
