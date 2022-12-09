//
//  CoreDataHandlerDelete.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 21.09.2022.
//

import CoreData

extension CoreDataHandler {
    typealias DeleteResult = Swift.Result<Void, Error>

    @available(*, deprecated, message: "Should use the async/await version")
    internal func delete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext, completion: @escaping (DeleteResult) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }

            do {
                let result = try self.executeDeleteIn(objectsId: objectsId, in: context)
                let saveResult = self.executeSaveIfNeededIn(on: result, in: context)
                completion(saveResult)
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }

    private func executeSaveIfNeededIn(on result: DeleteResult, in context: NSManagedObjectContext) -> DeleteResult {
        return result.flatMap {
            guard self.shouldExecuteSave(on: context) else {
                return .failure(DatabaseSaveError())
            }

            do {
                try executeSave(on: context)
                return .success(())
            } catch(let error) {
                return .failure(error)
            }
        }
    }

    private func executeDeleteIn(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext) throws -> DeleteResult {
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

extension CoreDataHandler {
    internal func delete(objectsId: [NSManagedObjectID], in context: NSManagedObjectContext) async throws {
        return try await context.perform { [weak self] in
            guard let self = self else { throw DatabaseSaveError() }

            do {
                try self.executeSave(on: context)
                try self.executeSaveIfNeeded(in: context)
            } catch (let error) {
                throw error
            }
        }
    }

    private func executeSaveIfNeeded(in context: NSManagedObjectContext) throws  {
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
