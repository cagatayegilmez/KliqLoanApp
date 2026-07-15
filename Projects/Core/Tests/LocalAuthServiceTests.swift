//
//  LocalAuthServiceTests.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

@testable import Core
import Foundation
import Testing

struct LocalAuthServiceTests {

    @Test func sessionIsEmptyByDefault() throws {
        let service = try makeService()

        #expect(!service.isLoggedIn)
    }

    @Test func loginPersistsSession() async throws {
        let service = try makeService()

        try await service.login(email: "user@kliq.com", password: "123456")

        #expect(service.isLoggedIn)
    }

    @Test func logoutClearsSession() async throws {
        let service = try makeService()
        try await service.login(email: "user@kliq.com", password: "123456")

        try await service.logout()

        #expect(!service.isLoggedIn)
    }

    /// Creates a service isolated with its own defaults suite
    private func makeService() throws -> AuthService {
        let suiteName = UUID().uuidString
        let userDefaults = try #require(UserDefaults(suiteName: suiteName))
        userDefaults.removePersistentDomain(forName: suiteName)
        return AuthService(suiteName: suiteName,
                           simulatedLatency: .zero)
    }
}
