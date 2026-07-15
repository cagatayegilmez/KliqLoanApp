//
//  LoginFeatureBuilder.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Core
import DesignSystem
import UIKit

/// Creates the Login feature module
@MainActor
public enum LoginFeatureBuilder {

    /// Builds the root view controller for the Login feature
    ///
    /// - Parameters:
    ///  - router: Router protocol item for routing screens
    ///  - authService: Auth service for session management
    public static func build(router: any RouterProtocol,
                             authService: any AuthServiceProtocol) -> UIViewController {
        let featureRouter = LoginFeatureRouter(appRouter: router)
        let viewModel = LoginFeatureViewModel(router: featureRouter,
                                              authService: authService)
        let view = LoginFeatureView(viewModel: viewModel)
        let viewController = LoginFeatureViewController(viewModel: viewModel)
        viewController.addSwiftUIView(view, hasNavBar: false)
        return viewController
    }
}
