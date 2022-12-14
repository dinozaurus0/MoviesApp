//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by Vlad Grigore Sima on 15.09.2022.
//

import UIKit

internal final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    internal var window: UIWindow?
    private let mainRouter: MainRouter

    // MARK: - Init
    override internal init() {
        let mainComposer = MainComposer()
        self.mainRouter = MainRouter(favouriteMoviesComposer: mainComposer)
        super.init()
    }

    // MARK: - UIWindowSceneDelegate
    internal func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        self.mainRouter.startApp(window: window)
        self.window = window
    }
}
