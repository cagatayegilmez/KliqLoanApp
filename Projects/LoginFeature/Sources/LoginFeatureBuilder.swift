//
//  LoginFeatureBuilder.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Core
import DesignSystem
import UIKit

@MainActor
public struct LoginFeatureBuilder {

    public static func build(router: any RouterProtocol) -> UIViewController {
        let featureRouter = LoginFeatureRouter(appRouter: router)
        let viewModel = LoginFeatureViewModel(router: featureRouter)
        let view = LoginFeatureView(viewModel: viewModel)
        let viewController = LoginFeatureViewController(viewModel: viewModel)
        viewController.addSwiftUIView(view, hasNavBar: false)
        return viewController
    }
}
