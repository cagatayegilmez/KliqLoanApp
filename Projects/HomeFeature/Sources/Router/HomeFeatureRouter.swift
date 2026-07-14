//
//  HomeFeatureRouter.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import Core

final class HomeFeatureRouter: HomeFeatureRoutingProtocol {

    private let appRouter: any RouterProtocol

    init(appRouter: any RouterProtocol) {
        self.appRouter = appRouter
    }

    func routeToLogout() {
        appRouter.setRoot(AppRoute.login, animated: true)
    }
}
