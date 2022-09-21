//
//  FavouriteMoviesCollection.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

internal struct FavouriteMoviesCollectionView: View {

    // MARK: - Properties
    private var gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @ObservedObject private var viewModel: FavouriteMoviesCollectionViewModel

    // MARK: - Init
    internal init(viewModel: FavouriteMoviesCollectionViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            errorMessageLabel
            moviesCollectionList
        }
    }

    private var moviesCollectionList: some View {
        ScrollView() {
            LazyVGrid(columns: gridLayout, spacing: 10.0) {
                ForEach(viewModel.favouriteMovies) { movie in
                    FavouriteMovieCell(dataSource: movie) { [weak viewModel] identifier in
                        viewModel?.didTapDislikeCell(from: identifier)
                    }.onTapGesture { [weak viewModel] in
                        viewModel?.didSelectCell(with: movie.id)
                    }
                }
            }
        }
        .padding(.horizontal, 10.0)
    }

    private var errorMessageLabel: some View {
        Text(viewModel.noEntryMessage)
            .font(Font.body)
            .fontWeight(.bold)
    }
}

internal struct FavouriteMoviesCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMoviesCollectionView(viewModel: createViewModel())
    }

    private static func createViewModel() -> FavouriteMoviesCollectionViewModel {
        let favouriteMoviesService = DummyFavouriteMoviesService()

        return FavouriteMoviesCollectionViewModel(moviesFetcher: favouriteMoviesService,
                                                  moviesDeleter: favouriteMoviesService,
                                                  router: DummyFavouriteMoviesRouter())
    }
}
