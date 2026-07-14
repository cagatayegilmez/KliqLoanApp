//
//  KLTextInput+Previews.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

private struct KLTextInputPreviewHost: View {
    @State private var text = ""
    @State private var lastCallback = "—"
    let configuration: KLTextInputConfiguration

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            KLTextInput(text: $text, configuration: configuration)
                .onTextChanged { lastCallback = $0 }
            Text("Binding: \"\(text)\"")
                .font(.caption)
                .foregroundStyle(KLColor.textPrimary)
            Text("onTextChanged: \"\(lastCallback)\"")
                .font(.caption)
                .foregroundStyle(KLColor.textPrimary)
            Spacer()
        }
        .padding(32)
        .background(KLColor.background)
    }
}

#Preview("Email") {
    KLTextInputPreviewHost(configuration: .email())
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
        @State private var password = ""

        var body: some View {
            VStack(spacing: 14) {
                Spacer()
                KLTextInput(text: $email, configuration: .email())
                KLTextInput(text: $password, configuration: .password())
                Spacer()
            }
            .padding(32)
            .background(KLColor.background)
        }
    }
    return LoginFormPreview()
}
