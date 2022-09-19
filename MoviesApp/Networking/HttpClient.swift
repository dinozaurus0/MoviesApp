//
//  HttpClient.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol HttpClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func executeRequest(path: String, completion: @escaping (Result) -> Void)
}
