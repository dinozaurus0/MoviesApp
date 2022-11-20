//
//  MovieFinderService0.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class MovieFinderService: MovieFinder {

    // MARK: - Properties
    private let httpClient: HttpClient

    // MARK: - Init
    internal init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    // MARK: - MovieFinder
    func find(by title: String) async throws -> APIMovie {
        guard let url = createURLComponents(using: title)?.url else {
            throw InvalidQueryParameters()
        }

        let result = try await httpClient.executeRequest(url: url)
        return try MovieFinderMapper.mapToMovies(response: result)
    }

    private func createURLComponents(using title: String) -> URLComponents? {
        var urlComponents = URLComponents(string: OMDBApiEndpoints.base.rawValue)
        urlComponents?.queryItems = [
            URLQueryItem(name: "apiKey", value: OMDBApiKey.value),
            URLQueryItem(name: "t", value: title),
            URLQueryItem(name: "plot", value: "full")]

        return urlComponents
    }
}
