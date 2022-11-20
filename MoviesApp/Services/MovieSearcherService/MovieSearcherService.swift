//
//  SearchMoviesService.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 20.09.2022.
//

import CoreData

internal final class MovieSearcherService {

    // MARK: - Properties
    private let context: NSManagedObjectContext
    private let databaseHandler: CoreDataHandler

    // MARK: - Init
    internal init(context: NSManagedObjectContext, databaseHandler: CoreDataHandler) {
        self.context = context
        self.databaseHandler = databaseHandler
    }
}

extension MovieSearcherService: MoviePersistent {
    internal func save(movie: Movie) async throws  {
        return try await databaseHandler.save(context: context, objectToSave: movie, mapper: MovieMapper.self)
    }
}

extension MovieSearcherService: MovieChecker {
    internal func doesMovieExist(with title: String) async throws -> Bool {
        let fetchRequest = createFetchRequest(title: title)

        let movies = try await databaseHandler.fetchObjects(fetchRequest, in: context, mapper: MovieEntityMapper.self)
        return self.checkIfEntityExists(from: movies)
    }

    private func checkIfEntityExists(from entities: [Movie]) -> Bool {
        !entities.isEmpty
    }

    private func createFetchRequest(title: String) -> NSFetchRequest<MovieEntity> {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieEntity.title), title)
        return fetchRequest
    }
}
