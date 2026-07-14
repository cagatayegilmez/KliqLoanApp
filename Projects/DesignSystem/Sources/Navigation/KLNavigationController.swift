//
//  KLNavigationController.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import UIKit

private enum Constant {

    static let titleFont = UIFont.boldSystemFont(ofSize: 18)
}

public final class KLNavigationController: UINavigationController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    private func configureAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(KLColor.background)
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(KLColor.textPrimary),
            .font: Constant.titleFont
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = UIColor(KLColor.accentIndigo)
    }
}
