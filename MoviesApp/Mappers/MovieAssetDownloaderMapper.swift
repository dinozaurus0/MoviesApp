//
//  MovieAssetDownloaderMapper.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal enum MovieAssetDownloaderMapper {
    internal static func mapToAsset(result: HttpClient.Result) -> MovieAssetDownloader.Result {
        return result.flatMap { (data, response) in
            return parseResponse(data: data, response: response)
        }
    }

    private static func parseResponse(data: Data, response: HTTPURLResponse) -> MovieAssetDownloader.Result {
        guard isResponseValid(response) else {
            return .failure(FailedRequestError())
        }

        return .success(data)
    }

    private static func isResponseValid(_ response: HTTPURLResponse) -> Bool {
        guard let type = response.mimeType else { return false }
        return (200...299).contains(response.statusCode) && type.hasPrefix("image")
    }
}
