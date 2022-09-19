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
        movieFinder.find(by: title) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let apiModel):
                self.handleSuccessfulMovieDownload(model: apiModel, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func handleSuccessfulMovieDownload(model: APIMovie, completion: @escaping (MovieFetcher.Result) -> Void) {
        downloadImageAsset(imagePath: model.imagePath) { result in
            let movieResult = result.map { imageData in
                Movie(title: model.title, description: model.description, image: imageData, rating: model.rating)
            }

            completion(movieResult)
        }
    }

    private func downloadImageAsset(imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        assetsDownloader.download(path: imagePath) { result in
            completion(result)
        }
    }
}
