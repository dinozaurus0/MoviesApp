//
//  PreviewProviderExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import SwiftUI

extension PreviewProvider {
    internal static func loadImageData(from path: String) -> Data {
        UIImage(contentsOfFile: path)?.pngData() ?? Data()
    }

    internal static func loadImagePath(for resource: String, type: String) -> String {
        Bundle.main.path(forResource: resource, ofType: type) ?? ""
    }
}
