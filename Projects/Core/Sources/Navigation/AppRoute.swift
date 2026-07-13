//
//  AppRoute.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

/// Central dependency of routing system
public protocol Route: Sendable {}

/// Central routing types
public enum AppRoute: Route, Equatable {

    /// Login screen routing
    case login

    /// Home screen routing
    case home
}
