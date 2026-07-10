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
public protocol LoanService {
    func fetchLoans() async throws -> [Loan]
    func persistLoans(_ loans: [Loan]) async throws
}

// MARK: - MockLoanService
class MockLoanService: LoanService {
    func fetchLoans() async throws -> [Loan] {
        guard let url = Bundle.main.url(forResource: "loans", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "LoanServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load loan data"])
        }
        return try JSONDecoder().decode([Loan].self, from: data)
    }

    func persistLoans(_ loans: [Loan]) async throws {
        print("Persisted \(loans.count) loans")
    }
}

// MARK: - LoanRepository
public class LoanRepository {
    private let service: LoanService

    public init(service: LoanService) {
        self.service = service
    }

    public func processAndUpdateLoans() async throws -> [Loan] {
        var loans = try await service.fetchLoans()

        for i in 0..<loans.count {
            // Interest rate adjustment based on type and status
            if loans[i].type == "personal" {
                if loans[i].status == "active" {
                    if loans[i].due_in > 0 {
                        loans[i].interest_rate += 0.3
                    } else {
                        if loans[i].principal_amount > 10000 {
                            loans[i].interest_rate += 1.2
                            loans[i].status = "overdue"
                        } else {
                            loans[i].interest_rate += 0.6
                        }
                    }
                } else if loans[i].status == "overdue" {
                    loans[i].interest_rate += 1.5
                    if loans[i].principal_amount > 20000 {
                        loans[i].status = "default"
                    }
                }
            } else if loans[i].type == "mortgage" {
                if loans[i].status == "active" {
                    if loans[i].due_in > 0 {
                        loans[i].interest_rate += 0.1
                    } else {
                        loans[i].interest_rate += 0.4
                        loans[i].status = "overdue"
                    }
                } else if loans[i].status == "overdue" {
                    loans[i].interest_rate += 0.8
                    if loans[i].due_in < -60 {
                        loans[i].status = "default"
                    }
                }
            } else if loans[i].type == "auto" {
                if loans[i].status == "active" {
                    if loans[i].due_in > 0 {
                        loans[i].interest_rate += 0.4
                    } else {
                        loans[i].interest_rate += 0.9
                        loans[i].status = "overdue"
                    }
                } else if loans[i].status == "overdue" {
                    loans[i].interest_rate += 1.8
                    if loans[i].principal_amount > 50000 {
                        loans[i].status = "default"
                    }
                }
            } else if loans[i].type == "business" {
                if loans[i].status == "active" {
                    if loans[i].due_in > 0 {
                        loans[i].interest_rate += 0.5
                    } else {
                        loans[i].interest_rate += 1.0
                        loans[i].status = "overdue"
                    }
                } else if loans[i].status == "overdue" {
                    loans[i].interest_rate += 2.0
                    if loans[i].principal_amount > 100000 {
                        loans[i].status = "default"
                    }
                }
            }

            // Due date processing
            loans[i].due_in -= 1

            if loans[i].due_in < -90 {
                if loans[i].status != "paid" {
                    loans[i].status = "default"
                }
            }

            if loans[i].principal_amount <= 0 {
                loans[i].status = "paid"
            }
        }

        try await service.persistLoans(loans)
        return loans
    }
}
