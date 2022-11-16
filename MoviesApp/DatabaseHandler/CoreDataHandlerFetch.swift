//
//  CoreDataHandlerFetch.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    @available(*, deprecated, message: "Use the async version instead")
    internal func fetchObjects<MapperType: CoredataConvertibleFrom>(_ fetchRequest: NSFetchRequest<MapperType.InputType>,
                                                                    in context: NSManagedObjectContext,
                                                                    mapper: MapperType.Type,
                                                                    completion: @escaping (Result<[MapperType.OutputType], Error>) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }

            self.fetch(using: fetchRequest, in: context) { [weak self] result in
                guard let self = self else { return }

                let parsedResult = self.handleEntitiesConvertion(from: result, mapper: mapper)
                completion(parsedResult)
            }
        }
    }

    private func handleEntitiesConvertion<MapperType: CoredataConvertibleFrom>(from result: Result<[MapperType.InputType], Error>,
                                                                               mapper: MapperType.Type) -> Result<[MapperType.OutputType], Error> {
        return result.map { entities in
            return entities.map { entity in
                return mapper.convert(input: entity)
            }
        }
    }
    
    private func fetch<ObjectType: NSFetchRequestResult>(using fetchRequest: NSFetchRequest<ObjectType>,
                                                         in context: NSManagedObjectContext,
                                                         completion: (Result<[ObjectType], Error>) -> Void) {
        do {
            let results = try context.fetch(fetchRequest)
            completion(.success(results))
        } catch  _ {
            completion(.failure(DatabaseFetchError()))
        }
    }
}

extension CoreDataHandler {
    internal func fetchObjects<MapperType: CoredataConvertibleFrom>(_ fetchRequest: NSFetchRequest<MapperType.InputType>,
                                                                    in context: NSManagedObjectContext,
                                                                    mapper: MapperType.Type) async throws -> [MapperType.OutputType] {
        try await context.perform { [weak self] in
            guard let self = self else { return }

            do {
                let entities = self.fetch(using: fetchRequest, in: context)
                return handleEntitiesConvertion(from: entities, mapper: mapper)
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
