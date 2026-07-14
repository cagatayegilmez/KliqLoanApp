//
//  KLButtonConfiguration.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import Foundation
import UIKit
import SwiftUI

public enum KLButtonType {

    /// Primary type button like sign in
    case primary
    /// Plain type button like logout
    case plain
}

public struct KLButtonConfiguration {

    public let style: KLButtonType
    public let title: String

    private init(style: KLButtonType,
                 title: String) {
        self.style = style
        self.title = title
    }

    /// Creates primary typed button
    ///
    /// - Parameter title: Title of button
    /// - Returns: Primary configurated KLButtonConfiguration object
    public static func primary(title: String) -> Self {
        .init(style: .primary, title: title)
    }

    /// Creates plain typed button
    ///
    /// - Parameter title: Title of button
    /// - Returns: Plain configurated KLButtonConfiguration object
    public static func plain(title: String) -> Self {
        .init(style: .plain, title: title)
    }
}


public extension KLButtonConfiguration {

    @MainActor
    func makeBarButtonItem(action: @escaping () -> Void) -> UIBarButtonItem {
        let item = UIBarButtonItem(
            title: title,
            primaryAction: UIAction { _ in action() }
        )
        item.tintColor = UIColor(KLColor.brandPrimary)

        if case .primary = style {
            assertionFailure("KLButtonConfiguration.primary can not be used with UIBarButtonItem.")
        }
        return item
    }
}
