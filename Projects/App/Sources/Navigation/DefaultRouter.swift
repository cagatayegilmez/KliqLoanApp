//
//  DefaultRouter.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import UIKit

@MainActor
final class DefaultRouter: RouterProtocol {

    private weak var navigationController: UINavigationController?
    private var factories: [ObjectIdentifier: (any Route) -> UIViewController?] = [:]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func register<R: Route>(_ routeType: R.Type,
                            factory: @escaping (R) -> UIViewController) {
        factories[ObjectIdentifier(routeType)] = { route in
            guard let route = route as? R else {
                return nil
            }

            return factory(route)
        }
    }

    // MARK: - RouterProtocol

    func setRoot(_ route: any Route, animated: Bool) {
        guard let controller = resolve(route) else {
            return
        }

        navigationController?.setViewControllers([controller], animated: animated)
    }

    func push(_ route: any Route, animated: Bool) {
        guard let controller = resolve(route) else {
            return
        }

        navigationController?.pushViewController(controller, animated: animated)
    }

    func present(_ route: any Route, animated: Bool) {
        guard let controller = resolve(route) else {
            return
        }

        navigationController?.present(controller, animated: animated)
    }

    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool) {
        navigationController?.presentedViewController?.dismiss(animated: animated)
    }

    // MARK: - Private

    private func resolve(_ route: any Route) -> UIViewController? {
        guard let controller = factories[ObjectIdentifier(type(of: route))]?(route) else {
            assertionFailure("No factory registered for route: \(route)")
            return nil
        }
        return controller
    }
}
