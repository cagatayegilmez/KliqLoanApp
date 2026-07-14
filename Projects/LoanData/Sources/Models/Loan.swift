//
//  Loan.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Foundation

public enum LoanType: String, CaseIterable, Codable, Sendable {

    /// Personal loan type
    case personal
    /// Mortgage loan type
    case mortgage
    /// Vehicle loan type
    case auto
    /// Commercial loan type
    case business
}

public enum LoanStatus: String, CaseIterable, Codable, Sendable {

    /// Active loan type
    case active = "Active"
    /// Tardy loan type
    case overdue = "Overdue"
    /// Default loan type
    case inDefault = "Default"
    /// Paid loan type
    case paid = "Paid"
}

public struct Loan: Codable, Hashable, Identifiable, Sendable {

    public var name: String
    public var principalAmount: Double
    public var interestRate: Double
    public var status: LoanStatus
    public var dueInDays: Int
    public var type: LoanType

    public var id: String {
        name
    }

    public init(name: String,
                principalAmount: Double,
                interestRate: Double,
                status: LoanStatus,
                dueInDays: Int,
                type: LoanType) {
        self.name = name
        self.principalAmount = principalAmount
        self.interestRate = interestRate
        self.status = status
        self.dueInDays = dueInDays
        self.type = type
    }

    enum CodingKeys: String, CodingKey {
        case name
        case principalAmount = "principal_amount"
        case interestRate = "interest_rate"
        case status
        case dueInDays = "due_in"
        case type
    }
}
