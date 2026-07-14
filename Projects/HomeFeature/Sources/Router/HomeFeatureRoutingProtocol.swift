//
//  HomeFeatureRoutingProtocol.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import UIKit

@MainActor
protocol HomeFeatureRoutingProtocol: Sendable {

    /// Routes to Login feature
    func routeToLogout()

    /// Presents alert controller
    func present(alert: UIAlertController)
}
