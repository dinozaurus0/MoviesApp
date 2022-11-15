//
//  MovieAssetDownloaderMapper.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal enum MovieAssetDownloaderMapper {
    internal static func mapToAsset(clientResponse: HttpClient.ClientResponse) throws -> Data {
        let (data, response) = clientResponse
        return try parseResponse(data: data, response: response)
    }

    private static func parseResponse(data: Data, response: HTTPURLResponse) throws -> Data {
        guard isResponseValid(response) else {
            throw FailedRequestError()
        }

        return data
    }

    private static func isResponseValid(_ response: HTTPURLResponse) -> Bool {
        guard let type = response.mimeType else { return false }
        return (200...299).contains(response.statusCode) && type.hasPrefix("image")
    }
}
