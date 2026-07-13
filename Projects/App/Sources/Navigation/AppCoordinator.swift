//
//  AppCoordinator.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import HomeFeature
import LoginFeature
import UIKit

@MainActor
final class AppCoordinator {

    private let window: UIWindow
    private let navigationController = UINavigationController()
    private let router: DefaultRouter

    init(window: UIWindow) {
        self.window = window
        self.router = DefaultRouter(navigationController: navigationController)
    }

    func start() {
        navigationController.navigationBar.prefersLargeTitles = true

        registerFeatures()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        router.setRoot(AppRoute.login, animated: false)
    }

    // MARK: - Feature registration

    private func registerFeatures() {
        router.register(AppRoute.self) { [unowned router] route in
            switch route {
            case .login:
                return LoginFeatureBuilder.build(router: router)
            case .home:
                return HomeFeatureBuilder.build(router: router)
            }
        }
    }
}
