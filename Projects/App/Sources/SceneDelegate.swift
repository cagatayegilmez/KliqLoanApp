//
//  SceneDelegate.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 10.07.2026.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window)

        self.window = window
        self.appCoordinator = coordinator

        coordinator.start()
    }
}
