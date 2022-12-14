//
//  MainComposerSearchMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import CoreData
import UIKit

extension MainComposer: SearchMoviesComposer {
    internal func createSearchController() -> UINavigationController {
        let movieFetcher = createMovieFetcherService()
        let searchBar = UISearchBar()

        let searchMovieService = createSearchMovieService()

        let navigationController = UINavigationController()
        let router = SearchMovieNavigationRouter(navigationController: navigationController)

        let viewModel = SearchMoviesViewModel(movieFetcher: movieFetcher,
                                              movieChecker: searchMovieService,
                                              moviePersistent: searchMovieService,
                                              router: router)
        let searchFieldDelegate = SearchFieldDelegate(delegate: viewModel)
        searchBar.delegate = searchFieldDelegate

        register(object: searchFieldDelegate)

        let hostingController = SearchMoviesHostingController(viewModel: viewModel,
                                                              searchBar: searchBar,
                                                              rootView: SearchMovieView(viewModel: viewModel)) { [weak self, weak searchFieldDelegate] in
            guard let self = self, let searchFieldDelegate = searchFieldDelegate else { return }

            self.unregister(object: searchFieldDelegate)
        }


        navigationController.addChild(hostingController)
        hostingController.didMove(toParent: navigationController)

        return navigationController
    }

    private func createMovieFetcherService() -> MovieFetcher {
        let httpClient = URLSessionHttpClient(urlSession: URLSession.shared)

        let movieFinder = MovieFinderService(httpClient: httpClient)
        let assertDownloader = MovieAssetDownloaderService(httpClient: httpClient)
        let movieFetcher = MovieFetcherService(assetsDownloader: assertDownloader, movieFinder: movieFinder)

        return movieFetcher
    }

    private func createSearchMovieService() -> MovieChecker & MoviePersistent {
        let coredataHandler = CoreDataHandler.shatedInstance()

        let backgroundContext = coredataHandler.persistenceContainer.newBackgroundContext()

        let movieSearcher = MovieSearcherService(context: backgroundContext, databaseHandler: coredataHandler)
        return movieSearcher
    }
}
