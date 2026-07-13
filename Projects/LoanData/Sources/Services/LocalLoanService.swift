//
//  LocalLoanService.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Foundation

public struct LocalLoanService: LoanService {

    private let simulatedLatency: Duration

    public init(simulatedLatency: Duration = .milliseconds(600)) {
        self.simulatedLatency = simulatedLatency
    }

    public func fetchLoans() async throws -> [Loan] {
        try await Task.sleep(for: simulatedLatency)

        guard let url = Bundle.module.url(forResource: "loans", withExtension: "json") else {
            throw LoanDataError.resourceNotFound("loans.json")
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Loan].self, from: data)
        } catch {
            throw LoanDataError.decodingFailed(underlying: error)
        }
    }

    public func persistLoans(_ loans: [Loan]) async throws {
        #if DEBUG
        print("\(loans.count) loans persisted")
        #endif
    }
}
