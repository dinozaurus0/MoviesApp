//
//  CoredataConvertible.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

// As the designated `save`/`shouldExecuteSave`, this methods should be called only from within the coredata handler methods, otherwise this will be bad multithreading access

internal protocol CoredataConvertibleTo {
    associatedtype InputType
    static func convert(input: InputType, context: NSManagedObjectContext)
}

internal protocol CoredataConvertibleFrom {
    associatedtype InputType where InputType: NSFetchRequestResult
    associatedtype OutputType

    static func convert(input: InputType) -> OutputType
}
