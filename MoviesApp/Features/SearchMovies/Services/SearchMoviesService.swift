//
//  SearchMoviesService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

internal final class SearchMoviesService {

    // MARK: - Properties
    private let fetchContext: NSManagedObjectContext
    private let saveContext: NSManagedObjectContext
    private let databaseHandler: CoreDataHandler


    // MARK: - Init
    internal init(fetchContext: NSManagedObjectContext, saveContext: NSManagedObjectContext, databaseHandler: CoreDataHandler) {
        self.fetchContext = fetchContext
        self.saveContext = saveContext
        self.databaseHandler = databaseHandler
    }
}

extension SearchMoviesService: MoviePersistent {
    internal func save(movie: Movie, completion: @escaping (MoviePersistent.Result) -> Void) {
        createMovieEntity(from: movie)
        databaseHandler.saveSync(context: saveContext)
        completion(.success(()))
    }

    private func createMovieEntity(from model: Movie) {
        let entity = MovieEntity(context: saveContext)
        entity.title = model.title
        entity.details = model.description
        entity.rating = model.rating
        entity.image = model.image
        entity.isFavourite = true
    }
}

extension SearchMoviesService: MovieChecker {
    internal func doesMovieExist(with title: String, completion: @escaping (MovieChecker.Result) -> Void) {
        let fetchRequest = createFetchRequest(title: title)
        databaseHandler.fetchObjects(fetchRequest, in: fetchContext) { [weak self] result in
            guard let self = self else { return }

            completion(self.checkIfEntityExists(from: result))
        }
    }

    private func checkIfEntityExists(from result: Result<[MovieEntity], Error>) -> MovieChecker.Result {
        return result.map { entities in
            !entities.isEmpty
        }
    }

    private func createFetchRequest(title: String) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.title), title)
        return fetchRequest
    }
}
