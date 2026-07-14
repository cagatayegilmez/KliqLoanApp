//
//  KLSegment+Previews.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

@MainActor
private enum LoanFilterSegments: Sendable {

    static let all = KLSegmentItem(id: UUID(), title: "All")
    static let active = KLSegmentItem(id: UUID(), title: "Active")
    static let overdue = KLSegmentItem(id: UUID(), title: "Overdue")
    static let defaulted = KLSegmentItem(id: UUID(), title: "Default")
    static let paid = KLSegmentItem(id: UUID(), title: "Paid")
    static let allItems: [KLSegmentItem] = [all, active, overdue, defaulted, paid]
}

#Preview("Loan Demo") {
    struct SegmentPreview: View {
        @State private var selection = LoanFilterSegments.all.id

        private var selectedTitle: String {
            LoanFilterSegments.allItems.first { $0.id == selection }?.title ?? ""
        }

        var body: some View {
            VStack(spacing: 16) {
                KLSegment(
                    selection: $selection,
                    configuration: .segments(LoanFilterSegments.allItems)
                )

                Text("Selected: \(selectedTitle)")
                    .font(.caption)
                    .foregroundStyle(KLColor.textPrimary)
                Spacer()
            }
            .padding(16)
            .background(KLColor.background)
        }
    }
    return SegmentPreview()
}
