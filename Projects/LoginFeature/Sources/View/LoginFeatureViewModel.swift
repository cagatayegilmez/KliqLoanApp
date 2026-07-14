//
//  LoginFeatureViewModel.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Foundation
import Observation

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
    @ObservationIgnored private let router: any LoginFeatureRoutingProtocol

    init(router: any LoginFeatureRoutingProtocol) {
        self.router = router
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

        router.routeToHome()
    }
}
