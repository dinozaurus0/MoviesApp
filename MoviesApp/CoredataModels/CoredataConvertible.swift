//
//  CoredataConvertible.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

// As the designated `save`/`shouldExecuteSave`, this methods should be called only from within the coredata handler methods, otherwise this will be bad multithreading access
internal protocol CoredataConvertibleTo {
    func convert(context: NSManagedObjectContext)
}

internal protocol CoredataConvertibleFrom {
    associatedtype ResultType
    func convert() -> ResultType
}
