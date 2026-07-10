//
//  LoanRepository.swift
//  KliqLoanApp
//
//  Created by Kliq Tech on 2.02.2025.
//

import Foundation

// MARK: - Loan Model
public struct Loan: Codable {

    var name: String
    var principal_amount: Double
    var interest_rate: Double
    var status: String
    var due_in: Int
    var type: String
}

// MARK: - LoanService Protocol

/// Dependention of loan servicing
public protocol LoanService {

    /// Fetches loan list
    ///
    /// - Returns: List of loan model
    func fetchLoans() async throws -> [Loan]

    /// Persists to loan list
    ///
    /// - Parameter loans: List of loan model
    ///  - Retruns: Async throw
    func persistLoans(_ loans: [Loan]) async throws
}

// MARK: - MockLoanService
class MockLoanService: LoanService {
    func fetchLoans() async throws -> [Loan] {
        guard let url = Bundle.main.url(forResource: "loans", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "LoanServiceError",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "Failed to load loan data"])
        }
        return try JSONDecoder().decode([Loan].self, from: data)
    }

    func persistLoans(_ loans: [Loan]) async throws {
        print("Persisted \(loans.count) loans")
    }
}

// MARK: - LoanRepository

/// Data source of Loan Repostory
public class LoanRepository {
    private let service: LoanService

    /// Initilizes Loan Repostory
    ///
    /// - Parameter service: Loan servicing protocol
    public init(service: LoanService) {
        self.service = service
    }

    /// Process loan data and updates values
    public func processAndUpdateLoans() async throws -> Result<[Loan], Error> {
        var loans = try await service.fetchLoans()

        for index in loans.indices {
            processLoan(&loans[index])
        }

        try await service.persistLoans(loans)
        return .success(loans)
    }

    private func processLoan(_ loan: inout Loan) {
        switch loan.type {
        case "personal":
            processPersonalLoan(&loan)
        case "mortgage":
            processMortgageLoan(&loan)
        case "auto":
            processAutoLoan(&loan)
        case "business":
            processBusinessLoan(&loan)
        default:
            break
        }

        processDueDate(&loan)
    }

    private func processPersonalLoan(_ loan: inout Loan) {
        switch loan.status {
        case "active":
            if loan.due_in > 0 {
                loan.interest_rate += 0.3
            } else if loan.principal_amount > 10000 {
                loan.interest_rate += 1.2
                loan.status = "overdue"
            } else {
                loan.interest_rate += 0.6
            }
        case "overdue":
            loan.interest_rate += 1.5
            if loan.principal_amount > 20000 {
                loan.status = "default"
            }
        default:
            break
        }
    }

    private func processMortgageLoan(_ loan: inout Loan) {
        switch loan.status {
        case "active":
            if loan.due_in > 0 {
                loan.interest_rate += 0.1
            } else {
                loan.interest_rate += 0.4
                loan.status = "overdue"
            }
        case "overdue":
            loan.interest_rate += 0.8
            if loan.due_in < -60 {
                loan.status = "default"
            }
        default:
            break
        }
    }

    private func processAutoLoan(_ loan: inout Loan) {
        switch loan.status {
        case "active":
            if loan.due_in > 0 {
                loan.interest_rate += 0.4
            } else {
                loan.interest_rate += 0.9
                loan.status = "overdue"
            }
        case "overdue":
            loan.interest_rate += 1.8
            if loan.principal_amount > 50000 {
                loan.status = "default"
            }
        default:
            break
        }
    }

    private func processBusinessLoan(_ loan: inout Loan) {
        switch loan.status {
        case "active":
            if loan.due_in > 0 {
                loan.interest_rate += 0.5
            } else {
                loan.interest_rate += 1.0
                loan.status = "overdue"
            }
        case "overdue":
            loan.interest_rate += 2.0
            if loan.principal_amount > 100000 {
                loan.status = "default"
            }
        default:
            break
        }
    }

    private func processDueDate(_ loan: inout Loan) {
        loan.due_in -= 1

        if loan.due_in < -90, loan.status != "paid" {
            loan.status = "default"
        }

        if loan.principal_amount <= 0 {
            loan.status = "paid"
        }
    }
}
