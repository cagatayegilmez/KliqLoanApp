//
//  HomeFeatureBuilder.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Core
import DesignSystem
import UIKit

@MainActor
public struct HomeFeatureBuilder {

    public static func build(router: any RouterProtocol) -> UIViewController {
        let viewModel = HomeFeatureViewModel()
        let view = HomeFeatureView(viewModel: viewModel)
        let viewController = HomeFeatureViewController(viewModel: viewModel)
        viewController.addSwiftUIView(view, hasNavBar: true)
        return viewController
    }
}
