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

    /// Replaces the navigation stack with the given route
    ///
    /// - Parameter route: Route object for base
    func setRoot(_ route: any Route) {
        setRoot(route, animated: true)
    }

    /// Pushes the given route onto the navigation stack
    ///
    /// - Parameter route: Route object for base
    func push(_ route: any Route) {
        push(route, animated: true)
    }

    /// Presents the given route modally
    ///
    /// - Parameter route: Route object for base
    func present(_ route: any Route) {
        present(route, animated: true)
    }

    /// Pops the top view controller from the navigation stack
    func pop() {
        pop(animated: true)
    }

    /// Dismisses the currently presented view controller
    func dismiss() {
        dismiss(animated: true)
    }
}
