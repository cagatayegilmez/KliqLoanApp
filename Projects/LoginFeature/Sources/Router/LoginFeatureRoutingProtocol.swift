//
//  LoginFeatureRoutingProtocol.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

@MainActor
protocol LoginFeatureRoutingProtocol: Sendable {

    /// Routes to Home feature
    func routeToHome()
}
