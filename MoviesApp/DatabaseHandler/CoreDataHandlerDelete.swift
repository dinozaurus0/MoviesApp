//
//  CoreDataHandlerDelete.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData


// TODO: This might not be neede anymore ??
extension CoreDataHandler {
    internal func delete(objects: [NSManagedObject], in context: NSManagedObjectContext) {
        context.perform { [weak self] in
            guard let self = self else { return }

            self.executeDelete(for: objects, in: context)
            guard self.shouldExecuteSave(on: context) else { return }
            self.executeSave(on: context)
        }
    }

    private func executeDelete(for objects: [NSManagedObject], in context: NSManagedObjectContext) {
        objects.forEach { object in
            context.delete(object)
        }
    }
}
