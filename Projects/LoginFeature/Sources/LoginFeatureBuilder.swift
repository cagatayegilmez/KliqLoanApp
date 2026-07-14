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
    /// - Parameter router: Router protocol item for routing screens
    public static func build(router: any RouterProtocol) -> UIViewController {
        let featureRouter = LoginFeatureRouter(appRouter: router)
        let viewModel = LoginFeatureViewModel(router: featureRouter)
        let view = LoginFeatureView(viewModel: viewModel)
        let viewController = LoginFeatureViewController(viewModel: viewModel)
        viewController.addSwiftUIView(view, hasNavBar: false)
        return viewController
    }
}
