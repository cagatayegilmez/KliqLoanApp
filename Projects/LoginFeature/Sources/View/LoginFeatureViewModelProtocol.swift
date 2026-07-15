//
//  LoginFeatureViewModelProtocol.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

@MainActor
protocol LoginFeatureViewModelProtocol: AnyObject {

    /// Email vlaue that user typed in input
    var email: String { get set }

    /// Password vlaue that user typed in input
    var password: String { get set }

    /// Error string for mail input
    var mailError: String? { get set }

    /// Error string for password input
    var passwordError: String? { get set }

    /// Triggers when error occurs
    var onError: ((Error) -> Void)? { get set }

    /// Triggers when sign in button tapped
    func signInButtonTapped() async

    /// Triggers when alert produced
    func presentAlert(_ alert: UIAlertController)
}
