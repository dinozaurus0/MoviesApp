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
    private let databaseHandler: CoreDataHandler

    // MARK: - Init
    internal init(fetchContext: NSManagedObjectContext, databaseHandler: CoreDataHandler) {
        self.fetchContext = fetchContext
        self.databaseHandler = databaseHandler
    }
}

extension FavouriteMoviesService: FavouriteMoviesFetcher {
    public func fetchMovies(completion: @escaping (FavouriteMoviesFetcher.Result) -> Void) {
        let fetchRequest = createFetchRequest()
        databaseHandler.fetchObjects(fetchRequest, in: fetchContext) { [weak self] result in
            self?.handleFetchResult(result, completion: completion)
        }
    }

    private func createFetchRequest() -> NSFetchRequest<MovieEntity> {
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
    public func dislikeMovie(with identifier: UUID) {}
}
