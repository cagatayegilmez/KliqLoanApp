//
//  LoginFeatureViewModel.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import Foundation
import Observation
import UIKit

private enum Constant {

    static let atCharacter = "@"
    static let mailEmptyError = "Please enter email"
    static let passwordEmptyError = "Please enter password"
    static let validMailError = "Please enter valid email"
    static let validPasswordError = "Password should be at least 6 characters"
    static let minPasswordCount = 6
}

@MainActor
@Observable
final class LoginFeatureViewModel: LoginFeatureViewModelProtocol {

    var email: String = ""
    var password: String = ""
    var mailError: String?
    var passwordError: String?
    var onError: ((any Error) -> Void)?

    @ObservationIgnored private let router: any LoginFeatureRoutingProtocol
    @ObservationIgnored private let authService: any AuthServiceProtocol

    init(router: any LoginFeatureRoutingProtocol,
         authService: any AuthServiceProtocol) {
        self.router = router
        self.authService = authService
    }

    func signInButtonTapped() async {
        guard !email.isEmpty && !password.isEmpty else {
            mailError = Constant.mailEmptyError
            passwordError = Constant.passwordEmptyError
            return
        }

        guard email.contains(Constant.atCharacter) else {
            mailError = Constant.validMailError
            return
        }

        guard password.count >= Constant.minPasswordCount else {
            passwordError = Constant.validPasswordError
            return
        }

        do {
            try await authService.login(email: email, password: password)
            router.routeToHome()
        } catch is CancellationError {
            return
        } catch {
            onError?(error)
        }
    }

    func presentAlert(_ alert: UIAlertController) {
        router.present(alert: alert)
    }
}
