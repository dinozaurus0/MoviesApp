//
//  CoreDataHandlerSave.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    internal func save<MapperType: CoredataConvertibleTo>(context: NSManagedObjectContext,
                                                          objectToSave: MapperType.InputType,
                                                          mapper: MapperType.Type) async throws {
        return try await context.perform { [weak self] in
            guard let self = self else { return }

            mapper.convert(input: objectToSave, context: context)
            guard self.shouldExecuteSave(on: context) else { return }

            try self.executeSave(on: context)
        }
    }
}
