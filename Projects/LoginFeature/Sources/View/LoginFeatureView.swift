//
//  LoginFeatureView.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import SwiftUI

@MainActor
private enum Constant {

    static let screenSize = UIScreen.main.bounds
    static var vStackInsetsWidth: CGFloat {
        Constant.screenSize.width - .spacing1600
    }
    static let logoName = "kliq_logo"
    static let emailPlaceholder = "E-mail address"
    static let passwordPlaceholder = "Password"
    static let signInButtonTitle = "Sign In"
}

struct LoginFeatureView: View {

    @State private var viewModel: LoginFeatureViewModelProtocol

    init(viewModel: LoginFeatureViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
    }

    @ViewBuilder private var content: some View {
        VStack(spacing: .spacing500) {
            // Icon image
            Image(Constant.logoName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constant.vStackInsetsWidth,
                       height: .spacing1250)

            // Email input
            KLTextInput(text: $viewModel.email,
                        error: $viewModel.mailError,
                        configuration: .email(placeholder: Constant.emailPlaceholder))
            .frame(width: Constant.vStackInsetsWidth, height: .spacing1200)

            // Password input
            KLTextInput(text: $viewModel.password,
                        error: $viewModel.passwordError,
                        configuration: .password(placeholder: Constant.passwordPlaceholder))
            .frame(width: Constant.vStackInsetsWidth, height: .spacing1200)

            // Sign in button
            KLButton(configuration: .primary(title: Constant.signInButtonTitle)) {
                Task {
                    await viewModel.signInButtonTapped()
                }
            }
            .frame(width: Constant.vStackInsetsWidth, height: .spacing1250)
        }
    }
}
