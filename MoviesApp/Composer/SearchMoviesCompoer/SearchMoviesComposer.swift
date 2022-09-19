//
//  SearchMoviesComposer.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import SwiftUI

internal protocol SearchMoviesComposer {
    func navigateToSearchController(dismissViewController: @escaping () -> Void) -> UINavigationController
}
