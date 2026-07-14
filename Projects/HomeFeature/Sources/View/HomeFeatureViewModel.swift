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

private enum Constant {

    static let segmentTitles: [String] = [
        "All",
        "Active",
        "Overdue",
        "Default",
        "Paid"
    ]
}

@MainActor
@Observable
final class HomeFeatureViewModel: HomeFeatureViewModelProtocol {

    var viewState: LoadState
    var filteredLoans: [Loan] = []
    var segments: [KLSegmentItem] = []
    var selectedSegment = UUID() {
        didSet {
            filterData()
        }
    }

    private var loans: [Loan] = []
    @ObservationIgnored private let router: any HomeFeatureRoutingProtocol
    @ObservationIgnored private let repository: any LoanRepositoryProtocol

    init(router: any HomeFeatureRoutingProtocol,
         repository: any LoanRepositoryProtocol) {
        self.router = router
        self.repository = repository
        self.viewState = .idle
    }

    func fetchLoans() async {
        viewState = .loading

        do {
            let loans = try await repository.loadLoans()
            self.loans = loans
            self.filteredLoans = loans
            Constant.segmentTitles.forEach {
                if $0 == "All" {
                    self.selectedSegment = UUID()
                    self.segments.append(KLSegmentItem(id: self.selectedSegment,
                                                       title: $0))
                } else {
                    self.segments.append(KLSegmentItem(id: UUID(),
                                                       title: $0))
                }
            }
            viewState = .loaded
        } catch is CancellationError {
            viewState = .idle
        } catch {
            viewState = .failed(message: error.localizedDescription)
        }
    }

    func logoButtonTapped() async {
        router.routeToLogout()
    }

    private func filterData() {
        let segmentName = segments.first {
            $0.id == selectedSegment
        }?.title ?? ""
        if segmentName == "All" {
            filteredLoans = loans
        } else {
            filteredLoans = loans.filter {
                $0.status.rawValue.lowercased() == segmentName.lowercased()
            }
        }
    }
}
