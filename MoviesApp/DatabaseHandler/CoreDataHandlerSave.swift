//
//  CoreDataHandlerSave.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    internal func saveAsync(context: NSManagedObjectContext) {
        context.perform { [weak self] in
            guard let self = self else { return }

            guard self.shouldExecuteSave(on: context) else { return }
            self.executeSave(on: context)
        }
    }

    internal func saveSync(context: NSManagedObjectContext) {
        context.performAndWait { [weak self] in
            guard let self = self else { return }

            guard self.shouldExecuteSave(on: context) else { return }
            self.executeSave(on: context)
        }
    }
}
