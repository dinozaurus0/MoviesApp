//
//  FavouriteMoviesService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

internal final class FavouriteMoviesService {

    // MARK: - Properties
    private let fetchContext: NSManagedObjectContext
    private let deleteContext: NSManagedObjectContext
    private let databaseHandler: CoreDataHandler
    

    // MARK: - Init
    internal init(fetchContext: NSManagedObjectContext, deleteContext: NSManagedObjectContext, databaseHandler: CoreDataHandler) {
        self.fetchContext = fetchContext
        self.deleteContext = deleteContext
        self.databaseHandler = databaseHandler
    }
}

extension FavouriteMoviesService: FavouriteMoviesFetcher {
    internal func fetchMovies() async throws -> [Movie] {
        let fetchRequest = createFavouriteMoviesFetchRequest()
        return try await databaseHandler.fetchObjects(fetchRequest, in: fetchContext, mapper: MovieEntityMapper.self)
    }

    private func createFavouriteMoviesFetchRequest() -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.isFavourite), NSNumber(value: true))
        return fetchRequest
    }
}

extension FavouriteMoviesService: FavouriteMoviesDeleter {
    public func remove(with title: String) async throws {
        let fetchRequest = createUpdateMovieFetchRequest(with: title)

        let objectsIdResult = try await databaseHandler.fetchObjects(fetchRequest, in: deleteContext, mapper: ManagedObjectIdMapper.self)
        try await databaseHandler.delete(objectsId: objectsIdResult, in: deleteContext)
    }

    private func createUpdateMovieFetchRequest(with title: String) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.title), title)
        return fetchRequest
    }
}
