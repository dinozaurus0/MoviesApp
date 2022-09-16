//
//  FavouritesMoviesHostingController.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI

internal final class FavouritesMoviesHostingController: UIHostingController<FavouriteMoviesCollection> {
    override init(rootView: FavouriteMoviesCollection) {
        super.init(rootView: rootView)
    }

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.text = "Favourites Movies"

        navigationItem.titleView = titleLabel
    }
}
