//
//  MockHomeFeatureViewModel.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 15.07.2026.
//

import Core
import DesignSystem
import Foundation
@testable import HomeFeature
import LoanData
import UIKit

private enum Constant {

    static let emptyString = ""
    static let allSegmentTitle = "All"
}

@MainActor
final class MockHomeFeatureViewModel: HomeFeatureViewModelProtocol {

    var viewState: LoadState = .idle
    var filteredLoans: [Loan] = []
    var summaryCardData = SummaryCardData(title: Constant.emptyString,
                                          detail: Constant.emptyString,
                                          footnote: Constant.emptyString)
    var segments: [KLSegmentItem] = []
    var selectedSegment = UUID() {
        didSet {
            filterLoans()
        }
    }
    var onError: ((any Error) -> Void)?

    var loansToReturn: [Loan] = []
    var loadError: (any Error)?
    private(set) var fetchLoansCallCount = 0
    private(set) var refreshLoansCallCount = 0
    private(set) var logoutCallCount = 0
    private(set) var presentedAlert: UIAlertController?

    private var loans: [Loan] = []

    func fetchLoans() async {
        fetchLoansCallCount += 1
        viewState = .loading

        if let loadError {
            completeLoad(with: loadError)
            return
        }

        loans = loansToReturn
        let allSegmentId = UUID()
        segments = [KLSegmentItem(id: allSegmentId,
                                  title: Constant.allSegmentTitle)]
        LoanStatus.allCases.forEach {
            segments.append(KLSegmentItem(id: UUID(),
                                          title: $0.rawValue.capitalized))
        }
        selectedSegment = allSegmentId
        viewState = .loaded
    }

    func refreshLoans() async {
        refreshLoansCallCount += 1

        if let loadError {
            completeLoad(with: loadError)
            return
        }

        loans = loansToReturn
        filterLoans()
    }

    func logoutButtonTapped() async {
        logoutCallCount += 1
    }

    func presentAlert(_ alert: UIAlertController) {
        presentedAlert = alert
    }

    private func completeLoad(with error: any Error) {
        if error is CancellationError {
            viewState = .idle
        } else {
            viewState = .failed
            onError?(error)
        }
    }

    private func filterLoans() {
        let segmentTitle = segments.first {
            $0.id == selectedSegment
        }?.title ?? Constant.emptyString
        if segmentTitle == Constant.allSegmentTitle {
            filteredLoans = loans
        } else {
            filteredLoans = loans.filter {
                $0.status.rawValue.lowercased() == segmentTitle.lowercased()
            }
        }
    }
}
