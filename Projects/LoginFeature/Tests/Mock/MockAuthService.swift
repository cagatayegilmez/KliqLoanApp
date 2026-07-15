//
//  MockAuthService.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

import Core
import Foundation

final class MockAuthService: AuthServiceProtocol, @unchecked Sendable {

    var isLoggedIn = false
    var loginError: (any Error)?
    private(set) var loginCallCount = 0
    private(set) var lastEmail: String?
    private(set) var lastPassword: String?

    func login(email: String, password: String) async throws {
        loginCallCount += 1
        lastEmail = email
        lastPassword = password

        if let loginError {
            throw loginError
        }

        isLoggedIn = true
    }

    func logout() async throws {
        isLoggedIn = false
    }
}
