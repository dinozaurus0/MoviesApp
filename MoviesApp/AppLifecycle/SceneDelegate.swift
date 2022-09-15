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

    // MARK: - UIWindowSceneDelegate
    internal func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
