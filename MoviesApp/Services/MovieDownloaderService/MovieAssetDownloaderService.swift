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

//        httpClient.executeRequest(url: url) { result in
//            let parsedResponse = MovieAssetDownloaderMapper.mapToAsset(result: result)
//            completion(parsedResponse)
//        }
    }

    internal func download(path: String) async throws -> Data {
        guard let url = URL(string: path) else {
            throw InvalidPath()
        }

        do {
            let result = try await httpClient.executeRequest(url: url)
            return try MovieAssetDownloaderMapper.mapToAsset(clientResponse: result)
        } catch(let error) {
            throw error
        }
    }
}
