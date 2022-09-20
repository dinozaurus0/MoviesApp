//
//  SearchMovieNavigationRouter.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import UIKit

internal final class SearchMovieNavigationRouter: SearchMovieRouter {

    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Init
    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - SearchMovieRouter
    internal func dimiss() {
        navigationController.dismiss(animated: true)
    }

    internal func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        navigationController.present(alertController, animated: true)
    }
}
