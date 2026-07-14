//
//  LoginFeatureRouter.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core

final class LoginFeatureRouter: LoginFeatureRoutingProtocol {

    private let appRouter: any RouterProtocol

    init(appRouter: any RouterProtocol) {
        self.appRouter = appRouter
    }

    func routeToHome() {
        appRouter.push(AppRoute.home, animated: true)
    }
}
