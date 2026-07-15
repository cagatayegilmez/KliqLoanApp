//
//  HomeFeatureViewController.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import UIKit

private enum Constant {

    static let navTitle = "Loan Portfolio"
    static let logoutTitle = "Logout"
    static let errorTitle = "Error"
    static let alertButtonTitle = "OK"
}

final class HomeFeatureViewController: UIViewController {

    private let viewModel: HomeFeatureViewModelProtocol
    private var logoutTask: Task<Void, Never>?

    init(viewModel: HomeFeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = Constant.navTitle
    }

    deinit {
        logoutTask?.cancel()
        logoutTask = nil
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonConfiguration = KLButtonConfiguration.plain(title: Constant.logoutTitle)
        navigationItem.rightBarButtonItem = buttonConfiguration.makeBarButtonItem { [weak self] in
            guard let self else {
                return
            }

            self.logoutTask?.cancel()
            self.logoutTask = Task {
                await self.viewModel.logoutButtonTapped()
            }
        }
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
