//
//  MockLoginFeatureRouter.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

@testable import LoginFeature
import UIKit

@MainActor
final class MockLoginFeatureRouter: LoginFeatureRoutingProtocol {

    private(set) var routeToHomeCallCount = 0
    private(set) var presentedAlert: UIAlertController?

    func routeToHome() {
        routeToHomeCallCount += 1
    }

    func present(alert: UIAlertController) {
        presentedAlert = alert
    }
}
