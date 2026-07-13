//
//  LoanProcessor.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

enum LoanProcessor {

    static func process(_ loan: Loan) -> Loan {
        var loan = loan

        switch loan.type {
        case .personal:
            applyPersonalRules(&loan)
        case .mortgage:
            applyMortgageRules(&loan)
        case .auto:
            applyAutoRules(&loan)
        case .business:
            applyBusinessRules(&loan)
        }

        applyDueDateRules(&loan)
        return loan
    }

    private static func applyPersonalRules(_ loan: inout Loan) {
        switch loan.status {
        case .active:
            if loan.dueInDays > 0 {
                loan.interestRate += 0.3
            } else if loan.principalAmount > 10_000 {
                loan.interestRate += 1.2
                loan.status = .overdue
            } else {
                loan.interestRate += 0.6
            }
        case .overdue:
            loan.interestRate += 1.5
            if loan.principalAmount > 20_000 {
                loan.status = .inDefault
            }
        case .inDefault, .paid:
            break
        }
    }

    private static func applyMortgageRules(_ loan: inout Loan) {
        switch loan.status {
        case .active:
            if loan.dueInDays > 0 {
                loan.interestRate += 0.1
            } else {
                loan.interestRate += 0.4
                loan.status = .overdue
            }
        case .overdue:
            loan.interestRate += 0.8
            if loan.dueInDays < -60 {
                loan.status = .inDefault
            }
        case .inDefault, .paid:
            break
        }
    }

    private static func applyAutoRules(_ loan: inout Loan) {
        switch loan.status {
        case .active:
            if loan.dueInDays > 0 {
                loan.interestRate += 0.4
            } else {
                loan.interestRate += 0.9
                loan.status = .overdue
            }
        case .overdue:
            loan.interestRate += 1.8
            if loan.principalAmount > 50_000 {
                loan.status = .inDefault
            }
        case .inDefault, .paid:
            break
        }
    }

    private static func applyBusinessRules(_ loan: inout Loan) {
        switch loan.status {
        case .active:
            if loan.dueInDays > 0 {
                loan.interestRate += 0.5
            } else {
                loan.interestRate += 1.0
                loan.status = .overdue
            }
        case .overdue:
            loan.interestRate += 2.0
            if loan.principalAmount > 100_000 {
                loan.status = .inDefault
            }
        case .inDefault, .paid:
            break
        }
    }

    private static func applyDueDateRules(_ loan: inout Loan) {
        loan.dueInDays -= 1

        if loan.dueInDays < -90, loan.status != .paid {
            loan.status = .inDefault
        }

        if loan.principalAmount <= 0 {
            loan.status = .paid
        }
    }
}
