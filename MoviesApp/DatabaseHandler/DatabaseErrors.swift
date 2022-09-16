//
//  DatabaseErrors.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import Foundation

internal struct DatabaseFetchError: Error {
    internal var localizedDescription: String {
        "Fetch operation failed!"
    }
}

internal struct DatabaseDeleteError: Error {
    internal var localizedDescription: String {
        "Delete operation failed!"
    }
}

internal struct DatabaseSaveError: Error {
    internal var localizedDescription: String {
        "Save operation failed!"
    }
}
