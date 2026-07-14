//
//  HomeFeatureViewModelProtocol.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Core
import DesignSystem
import Foundation
import LoanData

@MainActor
protocol HomeFeatureViewModelProtocol: AnyObject {

    /// Current loading state of the loan list
    var viewState: LoadState { get }

    /// List of loan data
    var filteredLoans: [Loan] { get }

    /// Segment list for display
    var segments: [KLSegmentItem] { get }

    /// Selected segment item's id
    var selectedSegment: UUID { get set }

    /// Fetches and processes the loan list
    func fetchLoans() async

    /// Triggers when logout button tapped on view controller
    func logoButtonTapped() async
}
