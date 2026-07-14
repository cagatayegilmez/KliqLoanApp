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
    static let errorSpacing: CGFloat = .spacing100
    static let errorAnimationDuration: TimeInterval = 0.15
}

public struct KLTextInput: View {

    @Binding private var text: String
    @Binding private var error: String?
    private let configuration: KLTextInputConfiguration
    private var onTextChanged: ((String) -> Void)?

    public init(text: Binding<String>,
                error: Binding<String?> = .constant(nil),
                configuration: KLTextInputConfiguration) {
        self._text = text
        self._error = error
        self.configuration = configuration
    }

    public func onTextChanged(_ action: @escaping (String) -> Void) -> Self {
        var copy = self
        copy.onTextChanged = action
        return copy
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Constant.errorSpacing) {
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
                        .stroke(borderColor, lineWidth: Constant.borderWidth)
                )

            if hasError {
                Text(error ?? "")
                    .font(.caption)
                    .foregroundStyle(KLColor.danger)
                    .padding(.horizontal, Constant.horizontalPadding)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: Constant.errorAnimationDuration), value: hasError)
        .onChange(of: text) { _, newValue in
            clearErrorIfNeeded()

            let sanitized = configuration.sanitize(newValue)
            if sanitized != newValue {
                text = sanitized
            } else {
                onTextChanged?(newValue)
            }
        }
    }
}

// MARK: - Subviews

private extension KLTextInput {

    @ViewBuilder var field: some View {
        if configuration.isSecure {
            SecureField(configuration.placeholder, text: $text)
        } else {
            TextField(configuration.placeholder, text: $text)
        }
    }
}

// MARK: - Error State

private extension KLTextInput {

    var hasError: Bool {
        guard let error else {
            return false
        }

        return !error.isEmpty
    }

    var borderColor: Color {
        hasError ? KLColor.danger : KLColor.border
    }

    /// Clears error state when user interacts with the field
    func clearErrorIfNeeded() {
        guard error != nil else {
            return
        }

        error = nil
    }
}
