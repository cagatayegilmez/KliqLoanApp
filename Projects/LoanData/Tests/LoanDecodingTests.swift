//
//  LoanDecodingTests.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Foundation
@testable import LoanData
import Testing

struct LoanDecodingTests {

    @Test func decodesSnakeCaseJSON() throws {
        let json = """
        [
            {
                "name": "Consumer Credit",
                "principal_amount": 8500,
                "interest_rate": 2.9,
                "status": "active",
                "due_in": 45,
                "type": "personal"
            }
        ]
        """

        let loans = try JSONDecoder().decode([Loan].self, from: Data(json.utf8))

        let loan = try #require(loans.first)
        #expect(loan.name == "Consumer Credit")
        #expect(loan.principalAmount == 8500)
        #expect(loan.interestRate == 2.9)
        #expect(loan.status == .active)
        #expect(loan.dueInDays == 45)
        #expect(loan.type == .personal)
    }

    @Test func decodesDefaultStatus() throws {
        let json = """
        {
            "name": "Commercial Credit",
            "principal_amount": 95000,
            "interest_rate": 4.3,
            "status": "default",
            "due_in": -40,
            "type": "business"
        }
        """

        let loan = try JSONDecoder().decode(Loan.self, from: Data(json.utf8))

        #expect(loan.status == .inDefault)
    }

    @Test func bundledDatasetDecodes() async throws {
        let service = LocalLoanService(simulatedLatency: .zero)

        let loans = try await service.fetchLoans()

        #expect(!loans.isEmpty)
    }
}
