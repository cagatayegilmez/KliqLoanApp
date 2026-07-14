//
//  Extensions.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import SwiftUI
import UIKit

@MainActor private var loadingViewKey: UInt8 = 0

@MainActor
public protocol SwiftUILoaderProtocol: AnyObject {

    func toggleLoading(isLoading: Bool)
}

private enum Constant {

    static let defaultBackgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
}

extension UIViewController: SwiftUILoaderProtocol {

    private var loadingView: LoadingView {
        if let view = objc_getAssociatedObject(self, &loadingViewKey) as? LoadingView {
            return view
        }

        let view = LoadingView()
        view.frame = self.view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        objc_setAssociatedObject(
            self,
            &loadingViewKey,
            view,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return view
    }

    @discardableResult
    public func addSwiftUIView<T: View>(_ swiftUIView: T, hasNavBar: Bool = false) -> UIView? {
        let hostingViewController = UIHostingController(rootView: swiftUIView)
        guard let rootView = hostingViewController.view else {
            return nil
        }

        rootView.translatesAutoresizingMaskIntoConstraints = false
        rootView.backgroundColor = Constant.defaultBackgroundColor

        view.addSubview(rootView)
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: hasNavBar
                                          ? view.safeAreaLayoutGuide.topAnchor
                                          : view.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        addChild(hostingViewController)
        hostingViewController.didMove(toParent: self)

        return rootView
    }

    func showLoading() {
        guard let window = view.window ?? foregroundKeyWindow else {
            return
        }

        loadingView.show(in: window)
    }

    private var foregroundKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }
    }

    func hideLoading() {
        loadingView.hide()
    }

    public func toggleLoading(isLoading: Bool) {
        switch isLoading {
        case true:
            showLoading()
        case false:
            hideLoading()
        }
    }
}
