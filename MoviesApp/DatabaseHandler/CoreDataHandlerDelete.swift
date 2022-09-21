//
//  CoreDataHandlerDelete.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import CoreData

extension CoreDataHandler {
    typealias DeleteResult = Swift.Result<Void, Error>

    internal func delete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext, completion: @escaping (DeleteResult) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }

            do {
                let result = try self.executeDelete(objectsId: objectsId, in: context)
                let saveResult = self.executeSaveIfNeeded(on: result, in: context)
                completion(saveResult)
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }

    private func executeSaveIfNeeded(on result: DeleteResult, in context: NSManagedObjectContext) -> DeleteResult {
        return result.flatMap {
            guard self.shouldExecuteSave(on: context) else {
                return .failure(DatabaseSaveError())
            }

            return executeSave(on: context)
        }
    }

    private func executeDelete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext) throws -> DeleteResult {
        try objectsId.forEach { id in
            do {
                let object = try context.existingObject(with: id)
                context.delete(object)
            } catch {
                context.rollback()
                throw DatabaseDeleteError()
            }
        }

        return .success(())
    }
}
