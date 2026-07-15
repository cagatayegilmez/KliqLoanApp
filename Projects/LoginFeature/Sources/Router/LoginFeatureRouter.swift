//
//  LoginFeatureRouter.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import UIKit

final class LoginFeatureRouter: LoginFeatureRoutingProtocol {

    private let appRouter: any RouterProtocol

    init(appRouter: any RouterProtocol) {
        self.appRouter = appRouter
    }

    func routeToHome() {
        appRouter.setRoot(AppRoute.home, animated: true)
    }

    func present(alert: UIAlertController) {
        appRouter.present(alert, animated: true)
    }
}
