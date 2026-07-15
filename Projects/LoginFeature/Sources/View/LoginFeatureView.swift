//
//  LoginFeatureView.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import SwiftUI

private enum Constant {

    static let logoName = "kliq_logo"
    static let emailPlaceholder = "E-mail address"
    static let passwordPlaceholder = "Password"
    static let signInButtonTitle = "Sign In"
}

private enum activeField: Hashable {

    /// Is email field active
    case email

    /// Is password field active
    case password
}

struct LoginFeatureView: View {

    @State private var viewModel: LoginFeatureViewModelProtocol
    @FocusState private var activeField: activeField?

    init(viewModel: LoginFeatureViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
    }

    // - MARK: Screen content

    @ViewBuilder private var content: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: .spacing500) {
                    // Icon image
                    Image(Constant.logoName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: .spacing1250)

                    // Email input
                    KLTextInput(text: $viewModel.email,
                                error: $viewModel.mailError,
                                configuration: .email(placeholder: Constant.emailPlaceholder))
                    .frame(height: .spacing1200)
                    .focused($activeField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        activeField = .password
                    }

                    // Password input
                    KLTextInput(text: $viewModel.password,
                                error: $viewModel.passwordError,
                                configuration: .password(placeholder: Constant.passwordPlaceholder))
                    .frame(height: .spacing1200)
                    .focused($activeField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        activeField = nil
                        submitForm()
                    }

                    // Sign in button
                    KLButton(configuration: .primary(title: Constant.signInButtonTitle)) {
                        submitForm()
                    }
                    .frame(height: .spacing1250)
                }
                .frame(maxWidth: .infinity,
                       minHeight: geometry.size.height)
                .padding(.horizontal, .spacing800)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    /// Submits form data for login
    private func submitForm() {
        Task {
            await viewModel.signInButtonTapped()
        }
    }
}
