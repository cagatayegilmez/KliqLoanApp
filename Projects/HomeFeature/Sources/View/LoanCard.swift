//
//  LoanCard.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

import DesignSystem
import LoanData
import SwiftUI

private enum Constant {

    static let cornerRadius: CGFloat = .spacing300
    static let badgeCornerRadius: CGFloat = .spacing100
    static let shadowOpacity = 0.06
    static let shadowRadius: CGFloat = .spacing150
    static let shadowYOffset: CGFloat = .spacing050
    static let currencyCode = "USD"
    static let interestInfo = "% interest"
    static let daysRemaining = "days remaining"
    static let dueToday = "Due today"
    static let daysOverdue = "days overdue"
}

struct LoanCard: View {

    let loan: Loan

    var body: some View {
        VStack(alignment: .leading, spacing: .spacing0) {
            header

            amountRow
                .padding(.top, .spacing250)

            Text(loan.dueDescription)
                .font(.textCaption)
                .foregroundStyle(loan.dueTint)
                .padding(.top, .spacing200)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, .spacing400)
        .padding(.vertical, .spacing350)
        .background(cardBackground)
    }

    // MARK: - Subviews

    private var header: some View {
        HStack(spacing: .spacing200) {
            Text(loan.name)
                .font(.cardTitle)
                .foregroundStyle(KLColor.textPrimary)

            LoanBadge(title: loan.type.badgeTitle, tint: loan.type.badgeTint)

            Spacer(minLength: .spacing200)

            LoanBadge(title: loan.status.badgeTitle, tint: loan.status.badgeTint)
        }
    }

    private var amountRow: some View {
        HStack(alignment: .firstTextBaseline, spacing: .spacing300) {
            Text(loan.principalAmount,
                 format: .currency(code: Constant.currencyCode).precision(.fractionLength(.zero)))
                .font(.sectionTitle)
                .foregroundStyle(KLColor.textPrimary)

            Text("\(loan.interestRate.formatted(.number.precision(.fractionLength(1))))\(Constant.interestInfo)")
                .font(.textCaption)
                .foregroundStyle(KLColor.textSecondary)
        }
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: Constant.cornerRadius)
            .fill(.white)
            .shadow(color: .black.opacity(Constant.shadowOpacity),
                    radius: Constant.shadowRadius,
                    x: .zero,
                    y: Constant.shadowYOffset)
    }
}

private struct LoanBadge: View {

    let title: String
    let tint: Color

    var body: some View {
        Text(title)
            .font(.textBadge)
            .foregroundStyle(.white)
            .padding(.horizontal, .spacing100)
            .padding(.vertical, .spacing050)
            .background(tint,
                        in: RoundedRectangle(
                            cornerRadius: Constant.badgeCornerRadius
                        ))
            .fixedSize()
    }
}

private extension LoanStatus {

    var badgeTitle: String {
        rawValue.uppercased()
    }

    var badgeTint: Color {
        switch self {
        case .active:
            KLColor.success
        case .overdue:
            KLColor.warning
        case .inDefault:
            KLColor.danger
        case .paid:
            KLColor.neutral
        }
    }
}

private extension LoanType {

    var badgeTitle: String {
        rawValue.uppercased()
    }

    var badgeTint: Color {
        switch self {
        case .personal:
            KLColor.accentIndigo
        case .mortgage:
            KLColor.accentBlue
        case .auto:
            KLColor.accentTeal
        case .business:
            KLColor.accentBrown
        }
    }
}

private extension Loan {

    var dueDescription: String {
        if dueInDays > .zero {
            "\(dueInDays) \(Constant.daysRemaining)"
        } else if dueInDays == .zero {
            Constant.dueToday
        } else {
            "\(abs(dueInDays)) \(Constant.daysOverdue)"
        }
    }

    var dueTint: Color {
        if dueInDays > .zero {
            KLColor.success
        } else if dueInDays == .zero {
            KLColor.warning
        } else {
            KLColor.danger
        }
    }
}
