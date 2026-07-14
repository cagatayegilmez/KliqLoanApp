//
//  KLTextInputConfiguration.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

public enum KLInputType {

    /// Email input field
    case email
    /// Password input field
    case password
    /// Amount entry input field
    case amount(maxFractionDigits: Int)
}

public struct KLTextInputConfiguration {

    public let type: KLInputType
    public let placeholder: String

    private init(type: KLInputType,
                 placeholder: String) {
        self.type = type
        self.placeholder = placeholder
    }

    /// Creates email input field
    ///
    /// - Parameter placeholder: Input field's placeholder string
    /// - Returns: Email configurated KLTextInputConfiguration object
    public static func email(placeholder: String = "E-mail address") -> Self {
        .init(type: .email, placeholder: placeholder)
    }

    /// Creates password input field
    ///
    /// - Parameter placeholder: Input field's placeholder string
    /// - Returns: Password configurated KLTextInputConfiguration object
    public static func password(placeholder: String = "Password") -> Self {
        .init(type: .password, placeholder: placeholder)
    }

    /// Creates amount entry input field
    ///
    /// - Parameters:
    ///  - placeholder: Input field's placeholder string
    ///  - maxFractionDigits: Digit counts for user can type maximum characters after comma
    /// - Returns: Email configurated KLTextInputConfiguration object
    public static func amount(placeholder: String = "0.00",
                              maxFractionDigits: Int = 2) -> Self {
        .init(type: .amount(maxFractionDigits: maxFractionDigits),
              placeholder: placeholder)
    }
}

extension KLTextInputConfiguration {

    /// Defines is input field must be secured
    var isSecure: Bool {
        if case .password = type {
            return true
        }

        return false
    }

    /// Defines input field's keyboard type
    var keyboardType: UIKeyboardType {
        switch type {
        case .email:
            return .emailAddress
        case .password:
            return .default
        case .amount:
            return .decimalPad
        }
    }

    /// Defines input field's content type for suggestions
    var contentType: UITextContentType? {
        switch type {
        case .email:
            return .emailAddress
        case .password:
            return .password
        case .amount:
            return nil
        }
    }

    /// Formats input amount string to formatted amount
    ///
    /// - Parameter raw: Raw string value of input field
    /// - Returns: String value of formatted amount
    func sanitize(_ raw: String) -> String {
        guard case let .amount(maxFractionDigits) = type else {
            return raw
        }

        let normalized = raw.replacingOccurrences(of: ",", with: ".")
        var result = ""
        var hasSeparator = false
        var fractionCount = 0

        for character in normalized {
            if character.isNumber {
                if hasSeparator {
                    guard fractionCount < maxFractionDigits else {
                        continue
                    }

                    fractionCount += 1
                }
                result.append(character)
            } else if character == ".", !hasSeparator, !result.isEmpty {
                hasSeparator = true
                result.append(character)
            }
        }
        return result
    }
}
