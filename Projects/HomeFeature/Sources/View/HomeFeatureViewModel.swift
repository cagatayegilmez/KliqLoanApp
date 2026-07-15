//
//  HomeFeatureViewModel.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import DesignSystem
import Foundation
import LoanData
import Observation
import UIKit

private enum Constant {

    static let emptyString = ""
    static let segmentTitles = [
        "All",
        "Active",
        "Overdue",
        "Default",
        "Paid"
    ]
    static let currencyCode = "USD"
    static let loansInPortfolio = "loans in portfolio"
    static let avgInterest = "Avg. interest rate:"
}

@MainActor
@Observable
final class HomeFeatureViewModel: HomeFeatureViewModelProtocol {

    var viewState: LoadState
    var filteredLoans: [Loan] = [] {
        didSet {
            createSummaryData()
        }
    }
    var summaryCardData = SummaryCardData(title: Constant.emptyString,
                                          detail: Constant.emptyString,
                                          footnote: Constant.emptyString)
    var segments: [KLSegmentItem] = []
    var selectedSegment = UUID() {
        didSet {
            filterData()
        }
    }
    var onError: ((any Error) -> Void)?

    private var loans: [Loan] = []
    @ObservationIgnored private let router: any HomeFeatureRoutingProtocol
    @ObservationIgnored private let repository: any LoanRepositoryProtocol
    @ObservationIgnored private let authService: any AuthServiceProtocol

    init(router: any HomeFeatureRoutingProtocol,
         repository: any LoanRepositoryProtocol,
         authService: any AuthServiceProtocol) {
        self.router = router
        self.repository = repository
        self.authService = authService
        self.viewState = .idle
    }

    func fetchLoans() async {
        viewState = .loading

        do {
            let loans = try await repository.loadLoans()
            self.loans = loans
            let allTypeSegmentId = UUID()
            Constant.segmentTitles.forEach {
                if $0 == Constant.segmentTitles.first {
                    self.segments.append(KLSegmentItem(id: allTypeSegmentId,
                                                       title: $0))
                } else {
                    self.segments.append(KLSegmentItem(id: UUID(),
                                                       title: $0))
                }
            }
            self.selectedSegment = allTypeSegmentId
            viewState = .loaded
        } catch is CancellationError {
            viewState = .idle
        } catch {
            viewState = .failed
            onError?(error)
        }
    }

    func refreshLoans() async {
        do {
            let loans = try await repository.loadLoans()
            self.loans = loans
            filterData()
        } catch is CancellationError {
            viewState = .idle
        } catch {
            viewState = .failed
            onError?(error)
        }
    }

    func logoButtonTapped() async {
        do {
            try await authService.logout()
            router.routeToLogout()
        } catch {
            onError?(error)
        }
    }

    func presentAlert(_ alert: UIAlertController) {
        router.present(alert: alert)
    }

    /// Filters loan data when selected segment changes
    private func filterData() {
        let segmentName = segments.first {
            $0.id == selectedSegment
        }?.title ?? Constant.emptyString
        if segmentName == Constant.segmentTitles.first {
            filteredLoans = loans
        } else {
            filteredLoans = loans.filter {
                $0.status.rawValue.lowercased() == segmentName.lowercased()
            }
        }
    }

    /// Filters loan data when selected segment changes
    private func createSummaryData() {
        let totals = filteredLoans.reduce(into: (principal: 0.0, rate: 0.0)) {
            $0.principal += $1.principalAmount
            $0.rate += $1.interestRate
        }

        let averageRate = filteredLoans.isEmpty
            ? 0
            : totals.rate / Double(filteredLoans.count)

        summaryCardData = SummaryCardData(
            title: totals.principal.formatted(.currency(code: Constant.currencyCode).precision(.fractionLength(.zero))),
            detail: "\(filteredLoans.count) \(Constant.loansInPortfolio)",
            footnote: "\(Constant.avgInterest) \(averageRate.formatted(.number.precision(.fractionLength(2))))%"
        )
    }
}
