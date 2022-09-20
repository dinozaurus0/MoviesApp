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
    internal func save(movie: Movie, completion: @escaping (MoviePersistent.Result) -> Void) {
        databaseHandler.save(context: context,
                             objectToSave: movie) { result in
            completion(result)
        }
    }
}

extension MovieSearcherService: MovieChecker {
    internal func doesMovieExist(with title: String, completion: @escaping (MovieChecker.Result) -> Void) {
        let fetchRequest = createFetchRequest(title: title)
        
        databaseHandler.fetchObjects(fetchRequest, in: context) { [weak self] result in
            guard let self = self else { return }

            let parsedResult = self.checkIfEntityExists(from: result)
            completion(parsedResult)
        }
    }

    private func checkIfEntityExists(from result: Result<[Movie], Error>) -> MovieChecker.Result {
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
