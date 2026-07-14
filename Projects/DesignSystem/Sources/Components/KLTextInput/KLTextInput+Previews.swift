//
//  KLTextInput+Previews.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

private struct KLTextInputPreviewHost: View {
    @State private var text = ""
    @State private var error: String?
    @State private var lastCallback = "—"
    let configuration: KLTextInputConfiguration
    let errorMessage: String?

    init(configuration: KLTextInputConfiguration, errorMessage: String? = nil) {
        self.configuration = configuration
        self.errorMessage = errorMessage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            KLTextInput(text: $text,
                        error: $error,
                        configuration: configuration)
                .onTextChanged { lastCallback = $0 }

            Text("Binding: \"\(text)\"")
                .font(.caption)
                .foregroundStyle(KLColor.textPrimary)
            Text("onTextChanged: \"\(lastCallback)\"")
                .font(.caption)
                .foregroundStyle(KLColor.textPrimary)
            Text("error: \"\(error ?? "nil")\"")
                .font(.caption)
                .foregroundStyle(KLColor.textPrimary)

            if let errorMessage {
                Button("Trigger Error") {
                    error = errorMessage
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding(32)
        .background(KLColor.background)
    }
}

#Preview("Email") {
    KLTextInputPreviewHost(configuration: .email())
}

#Preview("Email + Error") {
    KLTextInputPreviewHost(configuration: .email(),
                           errorMessage: "Please enter a valid e-mail address")
}

#Preview("Password") {
    KLTextInputPreviewHost(configuration: .password())
}

#Preview("Amount") {
    KLTextInputPreviewHost(configuration: .amount())
}

#Preview("Login Form") {
    struct LoginFormPreview: View {
        @State private var email = ""
        @State private var emailError: String?
        @State private var password = ""
        @State private var passwordError: String?

        var body: some View {
            VStack(spacing: 14) {
                Spacer()
                KLTextInput(text: $email,
                            error: $emailError,
                            configuration: .email())
                KLTextInput(text: $password,
                            error: $passwordError,
                            configuration: .password())
                Button("Validate") {
                    emailError = "Please enter a valid e-mail address"
                    passwordError = "Password must be at least 8 characters"
                }
                Spacer()
            }
            .padding(32)
            .background(KLColor.background)
        }
    }
    return LoginFormPreview()
}
