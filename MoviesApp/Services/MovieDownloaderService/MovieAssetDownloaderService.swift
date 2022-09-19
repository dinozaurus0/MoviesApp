//
//  MovieAssetDownloaderService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class MovieAssetDownloaderService: MovieAssetDownloader {

    // MARK: - Properties
    private let httpClient: HttpClient

    // MARK: - Init
    internal init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    // MARK: - MovieAssetDownloader
    internal func download(path: String, completion: @escaping (MovieAssetDownloader.Result) -> Void) {
        guard let url = URL(string: path) else { return }

        httpClient.executeRequest(url: url) { result in
            let parsedResponse = MovieAssetDownloaderMapper.mapToAsset(result: result)
            completion(parsedResponse)
        }
    }
}
