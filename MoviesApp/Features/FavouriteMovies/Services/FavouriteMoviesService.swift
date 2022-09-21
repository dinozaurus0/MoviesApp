//
//  FavouriteMoviesService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 16.09.2022.
//

import CoreData

public final class FavouriteMoviesService {

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
    internal func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        let fetchRequest = createFavouriteMoviesFetchRequest()

        databaseHandler.fetchObjects(fetchRequest, in: fetchContext, mapper: MovieEntityMapper.self) { result in
            completion(result)
        }
    }

    private func createFavouriteMoviesFetchRequest() -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.isFavourite), NSNumber(value: true))
        return fetchRequest
    }
}

extension FavouriteMoviesService: FavouriteMoviesDeleter {
    public func remove(with title: String, completion: @escaping (FavouriteMoviesDeleter.Result) -> Void) {
        let fetchRequest = createUpdateMovieFetchRequest(with: title)

        databaseHandler.fetchObjects(fetchRequest, in: deleteContext, mapper: ManagedObjectIdMapper.self) { [weak self] objectsIdResult in
            guard let self = self else { return }

            let parsedResult = self.deleteEntriesIfNeeded(objectsIdResult, completion: completion)
            completion(parsedResult)
        }
    }

    private func deleteEntriesIfNeeded(_ result: Result<[NSManagedObjectID], Error>,
                                       completion: @escaping (FavouriteMoviesDeleter.Result) -> Void) -> Result<Void, Error> {
        return result.map { objectsId in
            self.databaseHandler.delete(objectsId: objectsId, in: self.deleteContext) { deletionResult in
                completion(deletionResult)
            }
        }
    }

    private func createUpdateMovieFetchRequest(with title: String) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.title), title)
        return fetchRequest
    }
}
