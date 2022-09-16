//
//  FavouriteMoviesCollectionViewModelTests.swift
//  MoviesAppTests
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import XCTest
import MoviesApp

private let data = Data()

private struct FetcherError: Error {}

internal final class FavouriteMoviesCollectionViewModelTests: XCTestCase {

    // MARK: - Load movie list from a service

    func test_withEmptyInput_shouldReturnEmptyPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])))

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, [])
    }

    func test_withValidInput_shouldReturnPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)))

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, presentableFavouriteMovies)
    }

    func test_withEmptyInput_shouldShowEmptyInputMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])))

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "No favourite movies to display!")
    }

    func test_withErrorInput_shouldShowErrorMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.failure(FetcherError())))

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "There is a problem with movies fetching. Please try later!")
    }

    func test_withInput_shouldCallMoviesFetcher() {
        // given
        let fetcher = SpyFavouriteMoviesFetcher()
        let sut = makeSUT(moviesFetcher: fetcher)

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(fetcher.receivedMessages, [.fetchFavouritesMovies])
    }

    // MARK: - Helpers

    private func makeSUT(moviesFetcher: FavouriteMoviesFetcher) -> FavouriteMoviesCollectionViewModel {
        FavouriteMoviesCollectionViewModel(moviesFetcher: moviesFetcher)
    }

    private var favouriteMovies = [
        FavouriteMovie(title: "Game Of Thrones",
                       description: "A show with mad kings and cool queens",
                       image: data,
                       rating: 8.9),
        FavouriteMovie(title: "Vikings",
                       description: "A show with cool guys that fight each other over power",
                       image: data,
                       rating: 8.3),
        FavouriteMovie(title: "Black Sails",
                       description: "A lot of pirates over there",
                       image: data,
                       rating: 9.5)
    ]

    private var presentableFavouriteMovies = [
        PresentableFavouriteMovieCard(id: UUID(),
                                      title: "Game Of Thrones",
                                      description: "A show with mad kings and cool queens",
                                      image: data,
                                      rating: "8.9"),
        PresentableFavouriteMovieCard(id: UUID(),
                                      title: "Vikings",
                                      description: "A show with cool guys that fight each other over power",
                                      image: data,
                                      rating: "8.3"),
        PresentableFavouriteMovieCard(id: UUID(),
                                      title: "Black Sails",
                                      description: "A lot of pirates over there",
                                      image: data,
                                      rating: "9.5")
    ]
}


// Functionalites to implement
/*
 1. Load favourite data from a service. This should be a local cache. When this happens we should:
 1.2. Conver the given data into the `PResentableObject` for UI.
 1.1. If there is no data, just show an empty screen. If the fetch fails, do the same.
 2. When clicking on a film, navigate to details screen. When a cell is tapped should happen:
 2.1. Get all data from a local variable, send it to the new screen to work with.
 2.2. Call a router to navigate.
 3. Define a like/unlike button. When unlike clicked should happen:
 3.1. Delete the film from data source.
 3.2. Read new data source.
 3.3. Reload data on screen.
 4. Search for new content
 4.1 When search is pressed, we should navigate to the search screen. 
 */
// Let's go TDD for this screen only
