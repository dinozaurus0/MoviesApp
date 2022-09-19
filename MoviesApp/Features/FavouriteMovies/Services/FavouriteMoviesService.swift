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
    private let updateContext: NSManagedObjectContext
    private let databaseHandler: CoreDataHandler
    

    // MARK: - Init
    internal init(fetchContext: NSManagedObjectContext, updateContext: NSManagedObjectContext, databaseHandler: CoreDataHandler) {
        self.fetchContext = fetchContext
        self.updateContext = updateContext
        self.databaseHandler = databaseHandler
    }
}

extension FavouriteMoviesService: FavouriteMoviesFetcher {
    public func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        let fetchRequest = createFavouriteMoviesFetchRequest()
        databaseHandler.fetchObjects(fetchRequest, in: fetchContext) { [weak self] result in
            self?.handleFetchResult(result, completion: completion)
        }
    }

    private func createFavouriteMoviesFetchRequest() -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.isFavourite), NSNumber(value: true))
        return fetchRequest
    }

    private func handleFetchResult(_ result: Result<[MovieEntity], Error>,
                                   completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {

        switch result {
        case let .success(entities):
            let movies = computeMoviesFromEntities(using: entities)
            completion(.success(movies))
        case let .failure(error):
            completion(.failure(error))
        }
    }

    private func computeMoviesFromEntities(using entities: [MovieEntity]) -> [FavouriteMovie] {
        return entities.map { entity in
            FavouriteMovie(title: entity.title ?? "",
                           description: entity.details ?? "",
                           image: entity.image ?? Data(),
                           rating: entity.rating)
        }
    }
}

extension FavouriteMoviesService: FavouriteMoviesUpdater {
    public func dislikeMovie(with title: String, completion: @escaping (FavouriteMoviesUpdater.Result) -> Void) {
        let fetchRequest = createUpdateMovieFetchRequest(with: title)

        databaseHandler.fetchObjects(fetchRequest, in: updateContext) { [weak self] result in
            self?.handleMovieUpdateResult(result, completion: completion)
        }
    }

    private func handleMovieUpdateResult(_ result: Result<[MovieEntity], Error>,
                                         completion: (FavouriteMoviesUpdater.Result) -> Void) {
        switch result {
        case let .success(entities):
            dislikeEntities(using: entities)
            databaseHandler.saveSync(context: updateContext)
            databaseHandler.saveAsync(context: fetchContext)
            completion(.success(()))
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    private func dislikeEntities(using entities: [MovieEntity]) {
        entities.forEach { entity in
            entity.isFavourite = false
        }
    }

    private func createUpdateMovieFetchRequest(with title: String) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.title), title)
        return fetchRequest
    }
}
