//
//  KLButton+Previews.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

#Preview("Primary") {
    VStack(spacing: 14) {
        Spacer()
        KLButton(configuration: .primary(title: "Sign In")) {
            print("sign in tapped")
        }

        KLButton(configuration: .primary(title: "Sign In (disabled)")) {}
            .disabled(true)
        Spacer()
    }
    .padding(32)
    .background(KLColor.background)
}

#Preview("Plain") {
    KLButton(configuration: .plain(title: "Logout")) {
        print("logout tapped")
    }
    .padding(32)
    .background(KLColor.background)
}

#Preview("Login Form") {
    struct LoginPreview: View {
        @State private var email = ""
        @State private var password = ""

        var body: some View {
            VStack(spacing: 14) {
                Spacer()
                KLTextInput(text: $email, configuration: .email())
                KLTextInput(text: $password, configuration: .password())
                KLButton(configuration: .primary(title: "Sign In")) {
                    print("sign in: \(email)")
                }
                Spacer()
            }
            .padding(32)
            .background(KLColor.background)
        }
    }
    return LoginPreview()
}
