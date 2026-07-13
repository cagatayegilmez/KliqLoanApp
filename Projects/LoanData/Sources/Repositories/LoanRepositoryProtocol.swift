//
//  LoanRepositoryProtocol.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//


public protocol LoanRepositoryProtocol: Sendable {

    /// Fetches stored loan data from json file
    ///
    /// - Returns: An array of Loan data model
    func loadLoans() async throws -> [Loan]
}
