//
//  MovieEntityCoredataExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import Foundation
import CoreData

internal enum MovieEntityMapper: CoredataConvertibleFrom {
    internal static func convert(input: MovieEntity) -> Movie {
        Movie(title: input.title ?? "",
              description: input.details ?? "",
              image: input.image ?? Data(),
              rating: input.rating)
    }
}
