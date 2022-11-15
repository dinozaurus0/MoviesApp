//
//  MovieAssetDownloader.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieAssetDownloader {
    typealias Result = Swift.Result<Data, Error>

    @available(*, deprecated, message: "Use the async method instead")
    func download(path: String, completion: @escaping (Result) -> Void)
    
    func download(path: String) async throws -> Data
}
