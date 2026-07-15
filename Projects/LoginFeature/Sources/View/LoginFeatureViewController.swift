//
//  LoginFeatureViewController.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

private enum Constant {

    static let navTitle: String = "Kliq Loan"
    static let errorTitle = "Error"
    static let alertButtonTitle = "OK"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setOnErrorHandler()
    }

    private func setOnErrorHandler() {
        viewModel.onError = { [weak self] error in
            guard let self else {
                return
            }

            let alert = UIAlertController(title: Constant.errorTitle,
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(.init(title: Constant.alertButtonTitle,
                                  style: .cancel))
            self.viewModel.presentAlert(alert)
        }
    }
}
