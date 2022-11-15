//
//  MovieAssetDownloader.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol MovieAssetDownloader {
    func download(path: String) async throws -> Data
}
