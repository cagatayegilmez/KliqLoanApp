//
//  HomeFeatureViewController.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import UIKit

final class HomeFeatureViewController: UIViewController {

    private let viewModel: HomeFeatureViewModel

    init(viewModel: HomeFeatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
