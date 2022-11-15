//
//  HttpClient.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol HttpClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    typealias ClientResponse = (Data, HTTPURLResponse)

    func executeRequest(url: URL, completion: @escaping (Result) -> Void)
    func executeRequest(url: URL) async throws -> ClientResponse
}
