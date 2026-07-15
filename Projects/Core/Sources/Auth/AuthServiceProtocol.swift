//
//  AuthServiceProtocol.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

public protocol AuthServiceProtocol: Sendable {

    /// Indicates whether a user session is currently persisted
    var isLoggedIn: Bool { get }

    /// Logs in with the given credentials and persists the session
    ///
    /// - Parameters:
    ///  - email: Email address of the user
    ///  - password: Password of the user
    func login(email: String, password: String) async throws

    /// Logs out the current user and clears the persisted session
    func logout() async throws
}
