//
//  ImageExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import SwiftUI
import UIKit

extension Image {
    init?(data: Data) {
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
