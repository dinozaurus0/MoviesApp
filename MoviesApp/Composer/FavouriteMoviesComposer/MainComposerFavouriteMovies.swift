//
//  MainComposerFavouriteMovies.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 18.09.2022.
//

import Foundation
import UIKit
import CoreData

extension MainComposer: FavouriteMoviesComposer {
    internal func navigateToFavouriteMovies(navigationStack: UINavigationController) -> FavouritesMoviesHostingController {
        addDummyThingsToCoredata()
        let coredataHandler = CoreDataHandler.shatedInstance()
        let updateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        updateContext.parent = coredataHandler.mainContext
        let moviesService = FavouriteMoviesService(fetchContext: coredataHandler.mainContext,
                                                   updateContext: updateContext,
                                                   databaseHandler: coredataHandler)

        let router = FavouriteMoviesNavigationRouter(searchMoviesComposer: self,
                                                     navigationController: navigationStack)

        let viewModel = FavouriteMoviesCollectionViewModel(moviesFetcher: moviesService,
                                                           moviesUpdater: moviesService,
                                                           router: router)

        let favouriteMoviesCollectionView = FavouriteMoviesCollectionView(viewModel: viewModel)
        let favouriteMoviesViewController = FavouritesMoviesHostingController(rootView: favouriteMoviesCollectionView,
                                                                              viewModel: viewModel)

        return favouriteMoviesViewController
    }
}

// TODO: This is just for the compiler to allow the execution to happen. Will be converted into a propert router later on
private final class DummyClass: FavouriteMoviesRouter {
    func navigateToSearchScreen() {}

    func navigateToDetailsScreen(movieSelected: FavouriteMovie) {}

    internal static func loadImageData(from path: String) -> Data {
        UIImage(contentsOfFile: path)?.pngData() ?? Data()
    }

    internal static func loadImagePath(for resource: String, type: String) -> String {
        Bundle.main.path(forResource: resource, ofType: type) ?? ""
    }
}

private func addDummyThingsToCoredata() {
    CoreDataHandler.shatedInstance().persistenceContainer.performBackgroundTask { context in
        let movie0 = MovieEntity(context: context)
        movie0.title = "Game of thrones"
        movie0.details = "In the mythical continent of Westeros, several powerful families fight for control of the Seven Kingdoms. As conflict erupts in the kingdoms of men, an ancient enemy rises once again to threaten them all. Meanwhile, the last heirs of a recently usurped dynasty plot to take back their homeland from across the Narrow Sea."
        movie0.image = DummyClass.loadImageData(from: DummyClass.loadImagePath(for: "GOTImage", type: "jpeg"))
        movie0.rating = 9.4
        movie0.isFavourite = true

        let movie1 = MovieEntity(context: context)
        movie1.title = "Vikings"
        movie1.details = "The adventures of a Ragnar Lothbrok: the greatest hero of his age. The series tells the saga of Ragnar's band of Viking brothers and his family as he rises to become King of the Viking tribes. As well as being a fearless warrior, Ragnar embodies the Norse traditions of devotion to the gods: legend has it that he was a direct descendant of Odin, the god of war and warriors"
        movie1.rating = 8.9
        movie1.image = DummyClass.loadImageData(from: DummyClass.loadImagePath(for: "VikingsImage", type: "jpg"))
        movie1.isFavourite = true

        do {
           try context.save()
        } catch(let error) {
            print("Error saving stuff \(error)")
        }
    }
}

