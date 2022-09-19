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
    func find(by title: String, completion: @escaping (MovieFinder.Result) -> Void) {
        guard let url = createURLComponents(using: title)?.url else { return }

        httpClient.executeRequest(url: url) { result in
            let parsedResponse = MovieFinderMapper.mapToMovies(result: result)
            completion(parsedResponse)
        }
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
