//
//  LoginFeatureRoutingProtocol.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

@MainActor
protocol LoginFeatureRoutingProtocol: Sendable {

    /// Routes to Home feature
    func routeToHome()

    /// Presents alert controller
    func present(alert: UIAlertController)
}
