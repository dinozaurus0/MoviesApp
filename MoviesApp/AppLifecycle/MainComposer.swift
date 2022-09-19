//
//  MainComposer.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation

internal final class MainComposer {
    private var container: Set<NSObject> = []

    internal func register(object: NSObject) {
        container.insert(object)
    }

    internal func unregister(object: NSObject) {
        container.remove(object)
    }
}
