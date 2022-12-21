//
//  CoreDataHandlerFetch.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    internal func fetchObjects<MapperType: CoredataConvertibleFrom>(_ fetchRequest: NSFetchRequest<MapperType.InputType>,
                                                                    in context: NSManagedObjectContext,
                                                                    mapper: MapperType.Type) async throws -> [MapperType.OutputType] {
        return try await context.perform { [weak self] in
            guard let self = self else { return [] }

            do {
                let entities = try self.fetch(using: fetchRequest, in: context)
                return self.handleEntitiesConvertion(from: entities, mapper: mapper)
            } catch(let error) {
                throw error
            }
        }
    }

    private func fetch<ObjectType: NSFetchRequestResult>(using fetchRequest: NSFetchRequest<ObjectType>,
                                                         in context: NSManagedObjectContext) throws -> [ObjectType] {
        do {
            return try context.fetch(fetchRequest)
        } catch  _ {
            throw DatabaseFetchError()
        }
    }

    private func handleEntitiesConvertion<MapperType: CoredataConvertibleFrom>(from entities: [MapperType.InputType],
                                                                               mapper: MapperType.Type) -> [MapperType.OutputType] {
        return entities.map { entity in
            return mapper.convert(input: entity)
        }
    }
}
