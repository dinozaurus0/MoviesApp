//
//  MovieEntityCoredataExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation

extension MovieEntity: CoredataConvertibleFrom {
    internal func convert() -> Movie {
        Movie(title: self.title ?? "",
              description: self.details ?? "",
              image: self.image ?? Data(),
              rating: self.rating)
    }
}
