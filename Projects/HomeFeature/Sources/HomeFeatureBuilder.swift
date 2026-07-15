//
//  HomeFeatureBuilder.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Core
import DesignSystem
import LoanData
import UIKit

/// Creates the Home feature module
@MainActor
public enum HomeFeatureBuilder {

    /// Builds the root view controller for the Home feature
    ///
    /// - Parameters:
    ///  - router: Router protocol item for routing screens
    ///  - authService: Auth service for session management
    public static func build(router: any RouterProtocol,
                             authService: any AuthServiceProtocol) -> UIViewController {
        let loanRepostory = LoanRepository()
        let featureRouter = HomeFeatureRouter(appRouter: router)
        let viewModel = HomeFeatureViewModel(router: featureRouter,
                                             repository: loanRepostory,
                                             authService: authService)
        let viewController = HomeFeatureViewController(viewModel: viewModel)
        let view = HomeFeatureView(viewModel: viewModel, loader: viewController)
        viewController.addSwiftUIView(view, hasNavBar: true)
        return viewController
    }
}
