//
//  SummaryCard.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import DesignSystem
import SwiftUI

struct SummaryCardData: Equatable, Sendable {

    let title: String
    let detail: String
    let footnote: String
}

struct SummaryCard: View {

    private let data: SummaryCardData

    init(data: SummaryCardData) {
        self.data = data
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .spacing0) {
            Text(data.title)
                .font(.heroTitle)
                .foregroundStyle(KLColor.textSecondary)
            Text(data.detail)
                .font(.sectionTitle)
                .foregroundStyle(KLColor.textSecondary)
                .padding(.top, .spacing150)
            Text(data.footnote)
                .font(.footnote)
                .foregroundStyle(KLColor.textSecondary)
                .padding(.top, .spacing100)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, .spacing400)
        .padding(.horizontal, .spacing500)
        .background(KLColor.surfaceDark)
        .clipShape(RoundedRectangle(cornerRadius: .spacing350))
    }
}

// MARK: - Preview

#Preview {
    SummaryCard(data: .init(title: "$128,400",
                            detail: "12 loans in portfolio",
                            footnote: "Avg. interest rate: 14.25%"))
    .padding(.horizontal, .spacing400)
}
