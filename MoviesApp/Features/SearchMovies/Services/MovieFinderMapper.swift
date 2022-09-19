//
//  MovieFinderMapper.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal enum MovieFinderMapper {

    // MARK: - Public Method
    internal static func mapToMovies(result: HttpClient.Result) -> MovieFinder.Result {
        switch result {
        case let .success((data, response)):
            return parseResponse(data: data, response: response)
        case let .failure(error):
            return .failure(error)
        }
    }

    // MARK: - Private Methods
    private static func parseResponse(data: Data, response: HTTPURLResponse) -> MovieFinder.Result {
        guard isStatusCodeValid(response.statusCode) else {
            return .failure(FailedRequestError())
        }

        return decodeResponse(from: data)
    }

    private static func isStatusCodeValid(_ statusCode: Int) -> Bool {
        return (200...299).contains(statusCode)
    }

    private static func decodeResponse(from data: Data) -> MovieFinder.Result {
        do {
            let decodedResult = try JSONDecoder().decode(Movie.self, from: data)
            return .success(decodedResult)
        } catch {
            return .failure(ParseRequestError())
        }
    }
}
