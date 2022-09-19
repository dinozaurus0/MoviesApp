//
//  HttpError.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal struct InvalidUrlError: Error {
    internal var localizedDescription: String {
        "Invalid url for request!"
    }
}

internal struct FailedRequestError: Error {
    internal var localizedDescription: String {
        "Request failed!"
    }
}

internal struct ParseRequestError: Error {
    internal var localizedDescription: String {
        "Request data parsing failed!"
    }
}
