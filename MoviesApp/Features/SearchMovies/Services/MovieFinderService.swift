//
//  MovieFinderService.swift
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
    func find(by title: String, completion: @escaping (MovieFinder.Result) -> Void) {
        guard let url = createURLComponents(using: title)?.url else { return }

        // mapper-ul
        httpClient.executeRequest(url: url, completion: { _ in })
    }

    private func createURLComponents(using title: String) -> URLComponents? {
        var urlComponents = URLComponents(string: OMDBApiEndpoints.base.rawValue)
        urlComponents?.queryItems = [URLQueryItem(name: "t", value: title), URLQueryItem(name: "plot", value: "full")]

        return urlComponents
    }
}
