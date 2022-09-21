//
//  ManagedObjectIDCoredataMapper.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import CoreData

internal enum ManagedObjectId: CoredataConvertibleFrom {
    internal static func convert(input: MovieEntity) -> NSManagedObjectID {
        input.objectID
    }
}
