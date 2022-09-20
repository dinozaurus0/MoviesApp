//
//  SearchFieldDelegate.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 19.09.2022.
//

import UIKit

internal final class SearchFieldDelegate: NSObject {
    // MARK: - Properties
    private unowned let delegate: SearchFieldNotifier

    // MARK: - Init
    internal init(delegate: SearchFieldNotifier) {
        self.delegate = delegate
    }
}

extension SearchFieldDelegate: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate.didTapSearchButton(with: searchBar.text ?? "")
        searchBar.searchTextField.resignFirstResponder()
    }
}
