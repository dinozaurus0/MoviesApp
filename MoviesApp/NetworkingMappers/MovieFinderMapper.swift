//
//  MovieFinderMapper.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal enum MovieFinderMapper {

    // MARK: - Public Method
    internal static func mapToMovies(response: HttpClient.ClientResponse) throws -> APIMovie {
        let (data, response) = response
        return try parseResponse(data: data, response: response)
    }

    // MARK: - Private Methods
    private static func parseResponse(data: Data, response: HTTPURLResponse) throws -> APIMovie {
        guard isStatusCodeValid(response.statusCode) else {
            throw FailedRequestError()
        }

        return try decodeResponse(from: data)
    }

    private static func isStatusCodeValid(_ statusCode: Int) -> Bool {
        return (200...299).contains(statusCode)
    }

    private static func decodeResponse(from data: Data) throws -> APIMovie {
        do {
            let decodedResult = try JSONDecoder().decode(APIMovie.self, from: data)
            return decodedResult
        } catch {
            throw ParseRequestError()
        }
    }
}
