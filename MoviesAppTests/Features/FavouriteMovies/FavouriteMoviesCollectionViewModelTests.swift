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
    // MARK: - Helpers

    private func makeSUT(moviesFetcher: FavouriteMoviesFetcher, router: FavouriteMoviesRouter) -> FavouriteMoviesCollectionViewModel {
        FavouriteMoviesCollectionViewModel(moviesFetcher: moviesFetcher, router: router)
    }

    private func getIdentifier(from presentableMovies: [PresentableFavouriteMovieCard], forItemIndex: Int) -> UUID {
        presentableMovies[forItemIndex].id
    }

    private func selectFavouriteMovies(from index: Int) -> FavouriteMovie {
        favouriteMovies[index]
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

// MARK: - Load movie list from a service
extension FavouriteMoviesCollectionViewModelTests {
    func test_fetchAllMovies_withEmptyInput_shouldReturnEmptyPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])), router: SpyFavouriteMoviesRouter())

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, [])
    }

    func test_fetchAllMovies_withValidInput_shouldReturnPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: SpyFavouriteMoviesRouter())

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, presentableFavouriteMovies)
    }

    func test_fetchAllMovies_withEmptyInput_shouldShowEmptyInputMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])), router: SpyFavouriteMoviesRouter())

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "No favourite movies to display!")
    }

    func test_fetchAllMovies_withErrorInput_shouldShowErrorMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.failure(FetcherError())), router: SpyFavouriteMoviesRouter())

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "There is a problem with movies fetching. Please try later!")
    }

    func test_fetchAllMovies_withInput_shouldCallMoviesFetcher() {
        // given
        let fetcher = SpyFavouriteMoviesFetcher()
        let sut = makeSUT(moviesFetcher: fetcher, router: SpyFavouriteMoviesRouter())

        // when
        sut.fetchAllMovies()

        // then
        XCTAssertEqual(fetcher.receivedMessages, [.fetchFavouritesMovies])
    }
}

// MARK: - Navigate to details screen
extension FavouriteMoviesCollectionViewModelTests {
    func test_didSelectMovie_fromFirstIndex_shouldCallRouterWithFirstIndexDataSource() {
        // given
        let router = SpyFavouriteMoviesRouter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: router)
        sut.fetchAllMovies()
        let itemIdentifier = getIdentifier(from: sut.favouriteMovies, forItemIndex: 0)

        // when
        sut.didSelectCell(with: itemIdentifier)

        // then
        XCTAssertEqual(router.receivedMessages, [.navigateToDetailsScreen(movieSelected: selectFavouriteMovies(from: 0))])
    }

    func test_didSelectMovie_fromThirdIndex_shouldCallRouterWithThirdIndexDataSource() {
        // given
        let router = SpyFavouriteMoviesRouter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: router)
        sut.fetchAllMovies()
        let itemIdentifier = getIdentifier(from: sut.favouriteMovies, forItemIndex: 2)

        // when
        sut.didSelectCell(with: itemIdentifier)

        // then
        XCTAssertEqual(router.receivedMessages, [.navigateToDetailsScreen(movieSelected: selectFavouriteMovies(from: 2))])
    }

    func test_didTapSearch_shouldCallRouter() {
        // given
        let router = SpyFavouriteMoviesRouter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: router)
        sut.fetchAllMovies()

        // when
        sut.didTapSearch()

        // then
        XCTAssertEqual(router.receivedMessages, [.navigateToSearchScreen])
    }
}

// Functionalites to implement
/*
 3. Define a like/unlike button. When unlike clicked should happen:
 3.1. Delete the film from data source.
 3.2. Read new data source.
 3.3. Reload data on screen.
 */
// Let's go TDD for this screen only
