//
//  KLTextInput.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

private enum Constant {

    static let height: CGFloat = .spacing1200
    static let cornerRadius: CGFloat = .spacing200
    static let borderWidth: CGFloat = .spacing025
    static let horizontalPadding: CGFloat = .spacing300
}

public struct KLTextInput: View {

    @Binding private var text: String
    private let configuration: KLTextInputConfiguration
    private var onTextChanged: ((String) -> Void)?

    public init(text: Binding<String>, configuration: KLTextInputConfiguration) {
        self._text = text
        self.configuration = configuration
    }

    public func onTextChanged(_ action: @escaping (String) -> Void) -> Self {
        var copy = self
        copy.onTextChanged = action
        return copy
    }

    public var body: some View {
        field
            .keyboardType(configuration.keyboardType)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .textContentType(configuration.contentType)
            .padding(.horizontal, Constant.horizontalPadding)
            .frame(height: Constant.height)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: Constant.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: Constant.cornerRadius)
                    .stroke(KLColor.border, lineWidth: Constant.borderWidth)
            )
            .onChange(of: text) { _, newValue in
                let sanitized = configuration.sanitize(newValue)
                if sanitized != newValue {
                    text = sanitized
                } else {
                    onTextChanged?(newValue)
                }
            }
    }

    @ViewBuilder private var field: some View {
        if configuration.isSecure {
            SecureField(configuration.placeholder, text: $text)
        } else {
            TextField(configuration.placeholder, text: $text)
        }
    }
}
