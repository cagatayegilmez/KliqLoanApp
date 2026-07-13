//
//  LoanRepository.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

public struct LoanRepository: LoanRepositoryProtocol {

    private let service: any LoanService

    public init(service: any LoanService = LocalLoanService()) {
        self.service = service
    }

    public func loadLoans() async throws -> [Loan] {
        let loans = try await service.fetchLoans().map(LoanProcessor.process)
        try await service.persistLoans(loans)
        return loans
    }
}
