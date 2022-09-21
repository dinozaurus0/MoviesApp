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
private struct DeletionError: Error {}

internal final class FavouriteMoviesCollectionViewModelTests: XCTestCase {
    // MARK: - Helpers

    private func makeSUT(moviesFetcher: FavouriteMoviesFetcher,
                         moviesDeleter: FavouriteMoviesDeleter? = nil,
                         router: FavouriteMoviesRouter? = nil) -> FavouriteMoviesCollectionViewModel {
        FavouriteMoviesCollectionViewModel(moviesFetcher: moviesFetcher,
                                           moviesDeleter: moviesDeleter ?? SpyFavouriteMoviesDeleter(),
                                           router: router ?? SpyFavouriteMoviesRouter())
    }

    private func loadDataSource(from sut: FavouriteMoviesCollectionViewModel) {
        sut.loadMovies()
    }

    private func getIdentifier(from presentableMovies: [PresentableFavouriteMovieCard], forItemIndex: Int) -> UUID {
        presentableMovies[forItemIndex].id
    }

    private func selectFavouriteMovies(from index: Int) -> Movie {
        favouriteMovies[index]
    }

    private var favouriteMovies = [
        Movie(title: "Game Of Thrones",
              description: "A show with mad kings and cool queens",
              image: data,
              rating: 8.9),
        Movie(title: "Vikings",
              description: "A show with cool guys that fight each other over power",
              image: data,
              rating: 8.3),
        Movie(title: "Black Sails",
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
    func test_loadMovies_withEmptyInput_shouldReturnEmptyPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])))

        // when
        sut.loadMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, [])
    }

    func test_loadMovies_withValidInput_shouldReturnPresentableUIModels() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)))

        // when
        sut.loadMovies()

        // then
        XCTAssertEqual(sut.favouriteMovies, presentableFavouriteMovies)
    }

    func test_loadMovies_withEmptyInput_shouldShowEmptyInputMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success([])))

        // when
        sut.loadMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "No favourite movies to display!")
    }

    func test_loadMovies_withErrorInput_shouldShowErrorMessage() {
        // given
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.failure(FetcherError())))

        // when
        sut.loadMovies()

        // then
        XCTAssertEqual(sut.noEntryMessage, "There is a problem with movies fetching. Please try later!")
    }

    func test_loadMovies_withInput_shouldCallMoviesFetcher() {
        // given
        let fetcher = SpyFavouriteMoviesFetcher()
        let sut = makeSUT(moviesFetcher: fetcher, router: SpyFavouriteMoviesRouter())

        // when
        sut.loadMovies()

        // then
        XCTAssertEqual(fetcher.receivedMessages, [.fetchFavouritesMovies])
    }
}

// MARK: - Dislike Movie
extension FavouriteMoviesCollectionViewModelTests {
    func test_didTapDislikeCell_withFirstIdentifier_shouldCallMoviesDeleterWithSelectedIdentifier() {
        // given
        let updater = SpyFavouriteMoviesDeleter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), moviesDeleter: updater)
        loadDataSource(from: sut)
        let itemIdentifier = getIdentifier(from: sut.favouriteMovies, forItemIndex: 0)

        // when
        sut.didTapDislikeCell(from: itemIdentifier)

        // then
        XCTAssertEqual(updater.receivedMessages, [.deleteMovie(with: "Game Of Thrones")])
    }

    func test_didTapDislikeCell_withThirdIdentifier_shouldCallMoviesDeleterWithSelectedIdentifier() {
        // given
        let updater = SpyFavouriteMoviesDeleter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), moviesDeleter: updater)
        loadDataSource(from: sut)
        let itemIdentifier = getIdentifier(from: sut.favouriteMovies, forItemIndex: 2)

        // when
        sut.didTapDislikeCell(from: itemIdentifier)

        // then
        XCTAssertEqual(updater.receivedMessages, [.deleteMovie(with: "Black Sails")])
    }

    func test_didTapDislikeCell_withIdentifier_withSuccessfulDeleteOperation_shouldCallMoviesFetcher() {
        // given
        let fetcher = SpyFavouriteMoviesFetcher()
        let deleter = StubFavouriteMovieDeleter(expectedResult: Result.success(()))
        let sut = makeSUT(moviesFetcher: fetcher, moviesDeleter: deleter)

        // when
        sut.didTapDislikeCell(from: UUID())

        // then
        XCTAssertEqual(fetcher.receivedMessages, [.fetchFavouritesMovies])
    }

    func test_didTapDislikeCell_withIdentifier_withFailedDeleteOperation_shouldCallRouterWithPresentAlert() {
        // given
        let fetcher = StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies))
        let deleter = StubFavouriteMovieDeleter(expectedResult: Result.failure(DeletionError()))
        let router = SpyFavouriteMoviesRouter()

        let sut = makeSUT(moviesFetcher: fetcher, moviesDeleter: deleter, router: router)

        // when
        sut.loadMovies()
        sut.didTapDislikeCell(from: getIdentifier(from: sut.favouriteMovies, forItemIndex: 2))

        // then
        XCTAssertEqual(router.receivedMessages, [.presentAlert(title: "Deletion failed!",
                                                               message: "At this time, the deletion of the entry failed. Please try again later!")])
    }
}

// MARK: - Navigate to details screen
extension FavouriteMoviesCollectionViewModelTests {
    func test_didSelectMovie_fromFirstIdentifier_shouldCallRouterWithDataSourceFromFirstIdentifier() {
        // given
        let router = SpyFavouriteMoviesRouter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: router)
        loadDataSource(from: sut)
        let itemIdentifier = getIdentifier(from: sut.favouriteMovies, forItemIndex: 0)

        // when
        sut.didSelectCell(with: itemIdentifier)

        // then
        XCTAssertEqual(router.receivedMessages, [.navigateToDetailsScreen(movieSelected: selectFavouriteMovies(from: 0))])
    }

    func test_didSelectMovie_fromThirdIdentifier_shouldCallRouterWithDataSourceFromThirdIdentifier() {
        // given
        let router = SpyFavouriteMoviesRouter()
        let sut = makeSUT(moviesFetcher: StubFavouriteMoviesFetcher(expectedResult: Result.success(favouriteMovies)), router: router)
        loadDataSource(from: sut)
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
        loadDataSource(from: sut)

        // when
        sut.didTapSearch()

        // then
        XCTAssertEqual(router.receivedMessages, [.navigateToSearchScreen])
    }
}
