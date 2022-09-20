//
//  MovieCoredataExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

internal enum MovieMapper: CoredataConvertibleTo {
    internal static func convert(input: Movie, context: NSManagedObjectContext) {
        let entity = MovieEntity(context: context)
        entity.title = input.title
        entity.details = input.description
        entity.rating = input.rating
        entity.image = input.image
        entity.isFavourite = true
    }
}
