//
//  RouterProtocol.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

@MainActor
public protocol RouterProtocol: AnyObject {

    /// Replaces the navigation stack with the given route
    ///
    /// - Parameters:
    ///  - route: Route object for base
    ///  - animated: Using animation value
    func setRoot(_ route: any Route, animated: Bool)

    /// Pushes the given route onto the navigation stack
    ///
    /// - Parameters:
    ///  - route: Route object for base
    ///  - animated: Using animation value
    func push(_ route: any Route, animated: Bool)

    /// Presents the given route modally
    ///
    /// - Parameters:
    ///  - route: Route object for base
    ///  - animated: Using animation value
    func present(_ route: any Route, animated: Bool)

    /// Pops the top view controller from the navigation stack
    ///
    /// - Parameter animated: Using animation value
    func pop(animated: Bool)

    /// Dismisses the currently presented view controller
    ///
    /// - Parameter animated: Using animation value
    func dismiss(animated: Bool)
}

public extension RouterProtocol {

    func setRoot(_ route: any Route) {
        setRoot(route, animated: true)
    }

    func push(_ route: any Route) {
        push(route, animated: true)
    }

    func present(_ route: any Route) {
        present(route, animated: true)
    }

    func pop() {
        pop(animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
