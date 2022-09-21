//
//  CoreDataHandlerContextAccess.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

// These are common functions that should be called from `CoredataHandler` CRUD methods.
// If anyone wants to call them from other then the designated methods, than this methods have to be called from a `perform {}` block to avoid accessing the context on the wrong queue.

extension CoreDataHandler {
    internal func shouldExecuteSave(on context: NSManagedObjectContext) -> Bool {
        guard context.hasChanges else {
            return false
        }

        return true
    }

    internal func executeSave(on context: NSManagedObjectContext) -> SaveResult {
        do {
            try context.save()
            return .success(())
        } catch _ {
            context.rollback()
            return .failure(DatabaseSaveError())
        }
    }
}
