//
//  LoanService.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

public protocol LoanService: Sendable {

    /// Fetches the raw loan list
    ///
    /// - Returns: The loans as stored, before any processing
    func fetchLoans() async throws -> [Loan]

    /// Persists the given loan list
    ///
    /// - Parameter loans: The loans to store
    func persistLoans(_ loans: [Loan]) async throws
}
