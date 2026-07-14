//
//  HomeFeatureViewController.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import UIKit

private enum Constant {

    static let navTitle: String = "Loan Portfolio"
    static let logoutTitle: String = "Logout"
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
                await self.viewModel.logoButtonTapped()
            }
        }
    }
}
