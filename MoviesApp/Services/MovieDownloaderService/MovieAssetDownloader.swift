//
//  MovieAssetDownloader.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieAssetDownloader {
    typealias Result = Swift.Result<Data, Error>

    func download(path: String, completion: @escaping (Result) -> Void)
}
