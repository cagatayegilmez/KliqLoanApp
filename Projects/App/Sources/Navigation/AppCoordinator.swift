//
//  AppCoordinator.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import DesignSystem
import HomeFeature
import LoginFeature
import UIKit

@MainActor
final class AppCoordinator {

    private let window: UIWindow
    private let navigationController = KLNavigationController()
    private let router: DefaultRouter
    private let authService: any AuthServiceProtocol

    init(window: UIWindow,
         authService: any AuthServiceProtocol = AuthService()) {
        self.window = window
        self.router = DefaultRouter(navigationController: navigationController)
        self.authService = authService
    }

    func start() {
        registerFeatures()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let initialRoute: AppRoute = authService.isLoggedIn ? .home : .login
        router.setRoot(initialRoute, animated: false)
    }

    // MARK: - Feature registration

    private func registerFeatures() {
        router.register(AppRoute.self) { [unowned router, authService] route in
            switch route {
            case .login:
                return LoginFeatureBuilder.build(router: router,
                                                 authService: authService)
            case .home:
                return HomeFeatureBuilder.build(router: router,
                                                authService: authService)
            }
        }
    }
}
