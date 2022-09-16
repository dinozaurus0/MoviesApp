//
//  CoreDataStackCreator.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

private let bundle: Bundle = Bundle.main

/// An enum used to control where the database is located, it can be on disk or memory
internal enum StorageType {
    case disk
    case memory
}

internal final class CoreDataHandler {
    // MARK: - Properties
    internal let persistenceContainer: NSPersistentContainer
    internal let mainContext: NSManagedObjectContext
    private static var databaseName: String = "DungeonMasterModel"
    private static var storageType: StorageType = .disk

    private static var sharedDatabaseService: CoreDataHandler = {
        guard let modelURL = bundle.url(forResource: CoreDataHandler.databaseName, withExtension: ".momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not load the model from given URL")
        }

        let container = NSPersistentContainer(name: CoreDataHandler.databaseName, managedObjectModel: model)

        // For testing purpose, the storage will be in memory
        if CoreDataHandler.storageType == .memory {
            let description = NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null"))
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Could not create Persistance Container object with error \(error)")
            }
        }

        return CoreDataHandler(persistenceContainer: container, mainContext: container.viewContext)
    }()

    // MARK: - Init
    private init(persistenceContainer: NSPersistentContainer, mainContext: NSManagedObjectContext) {
        self.persistenceContainer = persistenceContainer
        self.mainContext = mainContext
    }

    internal static func shatedInstance() -> CoreDataHandler {
        return Self.sharedDatabaseService
    }
}
