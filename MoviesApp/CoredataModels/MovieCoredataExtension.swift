//
//  MovieCoredataExtension.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

// This extension should not live in the same module with the business rules because we want to present the `Movie` as a pure dependency that doesn't drag around `CoreData` refrences.

extension Movie: CoredataConvertibleTo {
    internal func convert(context: NSManagedObjectContext) {
        let entity = MovieEntity(context: context)
        entity.title = self.title
        entity.details = self.description
        entity.rating = self.rating
        entity.image = self.image
        entity.isFavourite = true
    }
}
