//
//  LoginFeatureViewController.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

private enum Constant {

    static let navTitle: String = "Kliq Loan"
}

final class LoginFeatureViewController: UIViewController {

    private let viewModel: LoginFeatureViewModelProtocol

    init(viewModel: LoginFeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = Constant.navTitle
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
