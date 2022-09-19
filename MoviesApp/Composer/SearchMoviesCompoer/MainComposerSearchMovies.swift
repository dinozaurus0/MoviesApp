//
//  MainComposerSearchMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import SwiftUI

extension MainComposer: SearchMoviesComposer {
    func navigateToSearchController(dismissViewController: @escaping () -> Void) -> UINavigationController {
        let movieFetcher = createMovieFetcherService()
        let searchBar = UISearchBar()

        let viewModel = SearchMoviesViewModel(movieFetcher: movieFetcher)
        let searchFieldDelegate = SearchFieldDelegate(delegate: viewModel)
        searchBar.delegate = searchFieldDelegate

        register(object: searchFieldDelegate)

        let hostingController = SearchMoviesHostingController(viewModel: viewModel,
                                                              searchBar: searchBar,
                                                              rootView: SearchMovieView(viewModel: viewModel)) { [weak self, weak searchFieldDelegate] in
            guard let self = self, let searchFieldDelegate = searchFieldDelegate else { return }

            self.unregister(object: searchFieldDelegate)
            dismissViewController()
        }

        return UINavigationController(rootViewController: hostingController)
    }

    private func createMovieFetcherService() -> MovieFetcher {
        let httpClient = URLSessionHttpClient(urlSession: URLSession.shared)

        let movieFinder = MovieFinderService(httpClient: httpClient)
        let assertDownloader = MovieAssetDownloaderService(httpClient: httpClient)
        let movieFetcher = MovieFetcherService(assetsDownloader: assertDownloader, movieFinder: movieFinder)

        return MainQueueDecorator(decoratee: movieFetcher)
    }
}
