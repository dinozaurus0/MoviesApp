//
//  CoreDataHandlerSave.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    typealias SaveResult = Swift.Result<Void, Error>

    internal func save<ObjectType: CoredataConvertibleTo>(context: NSManagedObjectContext,
                                                          objectToSave: ObjectType,
                                                          completion: @escaping (SaveResult) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }

            objectToSave.convert(context: context)
            guard self.shouldExecuteSave(on: context) else { return }

            let saveResult = self.executeSave(on: context)
            completion(saveResult)
        }
    }

    // TODO: Both will be deprecated
    internal func saveAsync(context: NSManagedObjectContext) {
        context.perform { [weak self] in
            guard let self = self else { return }

            guard self.shouldExecuteSave(on: context) else { return }
            self.executeSaveOn(on: context)
        }
    }

    internal func saveSync(context: NSManagedObjectContext) {
        context.performAndWait { [weak self] in
            guard let self = self else { return }

            guard self.shouldExecuteSave(on: context) else { return }
            self.executeSaveOn(on: context)
        }
    }
}
