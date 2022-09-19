//
//  MovieFetcherService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class MovieFetcherService: MovieFetcher {

    // MARK: - Properties
    private let assetsDownloader: MovieAssetDownloader
    private let movieFinder: MovieFinder

    // MARK: - Init
    internal init(assetsDownloader: MovieAssetDownloader, movieFinder: MovieFinder) {
        self.assetsDownloader = assetsDownloader
        self.movieFinder = movieFinder
    }

    // MARK: - MovieFinder
    func find(by title: String, completion: @escaping (MovieFetcher.Result) -> Void) {
        movieFinder.find(by: title) { result in
            switch result {
            case .success(let apiModel):
                self.assetsDownloader.download(path: apiModel.imagePath) { result in
                    switch result {
                    case .success(let imageData):
                        let mov = Movie(title: apiModel.title, description: apiModel.description, image: imageData, rating: apiModel.rating)
                    case .failure(let failure):
                        break
                    }
                }
            case .failure(let failure):
                break
            }
        }
    }
}

// Transport layer solve issue
// Split this into another 2 service, one fecthes raw data the other the image
// merge them back together
// Update UI
