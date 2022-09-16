//
//  CoreDataHandlerFetch.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

extension CoreDataHandler {
    internal func fetchObjects<ObjectType: NSFetchRequestResult>(_ fetchRequest: NSFetchRequest<ObjectType>,
                                                                 in context: NSManagedObjectContext,
                                                                 completion: @escaping (Result<[ObjectType], Error>) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }

            self.fetch(using: fetchRequest, in: context) { result in
                completion(result)
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
