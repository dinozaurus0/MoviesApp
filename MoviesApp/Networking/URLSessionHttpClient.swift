//
//  URLSessionHttpClient.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal final class URLSessionHttpClient: HttpClient {

    // MARK: - Properties
    private let urlSession: URLSession

    // MARK: - Init
    internal init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    // MARK: - Http Client
    internal func executeRequest(url: URL, completion: @escaping (HttpClient.Result) -> Void) {
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(FailedRequestError()))
                return
            }

            completion(.success((data, response)))
        }.resume()
    }
}
