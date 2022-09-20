//
//  SearchFieldNotifier.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import Foundation

internal protocol SearchFieldNotifier: AnyObject {
    func didTapSearchButton(with text: String)
}
