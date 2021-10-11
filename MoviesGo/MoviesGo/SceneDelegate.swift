// SceneDelegate.swift
// Copyright © Boris. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let menuViewModel = MenuViewModel()
        let vc = MenuViewController()
        vc.setupMenuViewModel(menuViewModel: menuViewModel)
        let navBar = UINavigationController(rootViewController: vc)
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
    }
}
