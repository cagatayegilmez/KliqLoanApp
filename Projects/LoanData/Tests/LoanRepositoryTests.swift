//
//  LoanRepositoryTests.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

@testable import LoanData
import Testing

struct LoanRepositoryTests {

    @Test func loadLoansProcessesAndPersists() async throws {
        let loan = Loan(
            name: "Consumer Credit",
            principalAmount: 8_500,
            interestRate: 2.9,
            status: .active,
            dueInDays: 45,
            type: .personal
        )
        let service = LoanServiceSpy(stubbedLoans: [loan])
        let repository = LoanRepository(service: service)

        let loans = try await repository.loadLoans()

        let processed = try #require(loans.first)
        #expect(abs(processed.interestRate - 3.2) < 1e-9)
        #expect(processed.dueInDays == 44)
        await #expect(service.persistedLoans() == loans)
    }

    @Test func loadLoansPropagatesServiceFailure() async {
        let service = LoanServiceSpy(stubbedError: LoanDataError.resourceNotFound("loans.json"))
        let repository = LoanRepository(service: service)

        await #expect(throws: LoanDataError.self) {
            try await repository.loadLoans()
        }
    }
}

/// Records persisted loans and returns stubbed fetch results.
private actor LoanServiceSpy: LoanService {

    private let stubbedLoans: [Loan]
    private let stubbedError: (any Error)?
    private var persisted: [Loan] = []

    init(stubbedLoans: [Loan] = [], stubbedError: (any Error)? = nil) {
        self.stubbedLoans = stubbedLoans
        self.stubbedError = stubbedError
    }

    func fetchLoans() async throws -> [Loan] {
        if let stubbedError {
            throw stubbedError
        }
        return stubbedLoans
    }

    func persistLoans(_ loans: [Loan]) async throws {
        persisted = loans
    }

    func persistedLoans() -> [Loan] {
        persisted
    }
}
