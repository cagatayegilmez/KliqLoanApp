//
//  HomeFeatureRoutingProtocol.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

@MainActor
protocol HomeFeatureRoutingProtocol: Sendable {

    /// Routes to Login feature
    func routeToLogout()
}
