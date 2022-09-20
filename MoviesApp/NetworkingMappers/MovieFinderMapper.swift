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
        return result.flatMap { (data: Data, response: HTTPURLResponse) in
            return parseResponse(data: data, response: response)
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
            let decodedResult = try JSONDecoder().decode(APIMovie.self, from: data)
            return .success(decodedResult)
        } catch(let error) {
            print(error)
            return .failure(ParseRequestError())
        }
    }
}
