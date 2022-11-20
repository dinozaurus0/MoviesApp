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
    internal func find(by title: String) async throws -> Movie {
        let movie = try await movieFinder.find(by: title)
        return try await handleSuccessfulMovieDownload(model: movie)
    }

    private func handleSuccessfulMovieDownload(model: APIMovie) async throws -> Movie {
        let imageData = try await downloadImageAsset(imagePath: model.imagePath)
        return Movie(title: model.title, description: model.description, image: imageData, rating: model.rating)
    }

    private func downloadImageAsset(imagePath: String) async throws -> Data {
        return try await assetsDownloader.download(path: imagePath)
    }
}
