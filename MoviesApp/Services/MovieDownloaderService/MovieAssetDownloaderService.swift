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
    internal func download(path: String) async throws -> Data {
        guard let url = URL(string: path) else {
            throw InvalidPath()
        }

        let result = try await httpClient.executeRequest(url: url)
        return try MovieAssetDownloaderMapper.mapToAsset(clientResponse: result)
    }
}
