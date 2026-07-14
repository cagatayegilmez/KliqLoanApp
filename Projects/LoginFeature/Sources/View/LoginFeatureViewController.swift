//
//  LoginFeatureViewController.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

final class LoginFeatureViewController: UIViewController {

    private let viewModel: LoginFeatureViewModel

    init(viewModel: LoginFeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
