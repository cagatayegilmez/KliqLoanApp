//
//  KLButton.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

private enum Constant {

    static let primaryHeight: CGFloat = .spacing1250
    static let primaryCornerRadius: CGFloat = .spacing250
    static let easeOutDuration: TimeInterval = 0.12
    static let disabledOpacity: Double = 0.5
    static let pressedOpacity: Double = 0.7
    static let enabledOpacity: Double = 1.0
}

public struct KLButton: View {

    private let configuration: KLButtonConfiguration
    private let action: () -> Void

    public init(configuration: KLButtonConfiguration,
                action: @escaping () -> Void) {
        self.configuration = configuration
        self.action = action
    }

    public var body: some View {
        Button(configuration.title, action: action)
            .buttonStyle(KLButtonStyle(style: configuration.style))
    }
}

private struct KLButtonStyle: ButtonStyle {

    let style: KLButtonType
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        styledLabel(configuration.label)
            .opacity(opacity(isPressed: configuration.isPressed))
            .animation(.easeOut(duration: Constant.easeOutDuration),
                       value: configuration.isPressed)
    }

    @ViewBuilder
    private func styledLabel(_ label: Configuration.Label) -> some View {
        switch style {
        case .primary:
            label
                .font(.buttonLabel)
                .foregroundStyle(KLColor.overlayLight)
                .frame(maxWidth: .infinity)
                .frame(height: Constant.primaryHeight)
                .background(KLColor.brandPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Constant.primaryCornerRadius))

        case .plain:
            label
                .font(.buttonLabel)
                .foregroundStyle(KLColor.brandPrimary)
        }
    }

    private func opacity(isPressed: Bool) -> Double {
        guard isEnabled else {
            return Constant.disabledOpacity
        }

        return isPressed
        ? Constant.pressedOpacity
        : Constant.enabledOpacity
    }
}
