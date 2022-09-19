//
//  MainComposerSearchMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import SwiftUI

extension MainComposer: SearchMoviesComposer {
    func navigateToSearchController() -> UIHostingController<SearchMoviesListView> {
        let hostingController = SearchMoviesHostingController(rootView: SearchMoviesListView())

        return hostingController
    }
}
