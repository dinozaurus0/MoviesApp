//
//  CoreDataHandlerDelete.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import CoreData

extension CoreDataHandler {
    internal func delete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext) async throws {
        return try await context.perform { [weak self] in
            guard let self = self else { throw DatabaseSaveError() }

            do {
                try self.executeDelete(objectsId: objectsId, in: context)
                try self.executeSaveIfNeeded(in: context)
            } catch (let error) {
                throw error
            }
        }
    }

    private func executeSaveIfNeeded(in context: NSManagedObjectContext) throws {
        guard self.shouldExecuteSave(on: context) else {
            throw DatabaseSaveError()
        }

        try executeSave(on: context)
    }

    private func executeDelete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext) throws {
        try objectsId.forEach { id in
            do {
                let object = try context.existingObject(with: id)
                context.delete(object)
            } catch {
                context.rollback()
                throw DatabaseDeleteError()
            }
        }
    }
}
