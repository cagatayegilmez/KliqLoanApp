//
//  AuthService.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

import Foundation

private enum Constant {

    static let sessionEmailKey = "com.kliqloan.auth.sessionEmail"
}

public struct AuthService: AuthServiceProtocol {

    private let suiteName: String?
    private let simulatedLatency: Duration

    private var userDefaults: UserDefaults {
        suiteName.flatMap { UserDefaults(suiteName: $0) } ?? .standard
    }

    public var isLoggedIn: Bool {
        userDefaults.string(forKey: Constant.sessionEmailKey) != nil
    }

    public init(suiteName: String? = nil,
                simulatedLatency: Duration = .milliseconds(600)) {
        self.suiteName = suiteName
        self.simulatedLatency = simulatedLatency
    }

    public func login(email: String, password: String) async throws {
        try await Task.sleep(for: simulatedLatency)
        userDefaults.set(email, forKey: Constant.sessionEmailKey)
    }

    public func logout() async throws {
        userDefaults.removeObject(forKey: Constant.sessionEmailKey)
    }
}
