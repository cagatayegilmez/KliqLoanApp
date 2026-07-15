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
import UIKit

@MainActor
protocol HomeFeatureViewModelProtocol: AnyObject {

    /// Current loading state of the loan list
    var viewState: LoadState { get }

    /// List of loan data
    var filteredLoans: [Loan] { get }

    /// Provided data for summary card
    var summaryCardData: SummaryCardData { get }

    /// Segment list for display
    var segments: [KLSegmentItem] { get }

    /// Selected segment item's id
    var selectedSegment: UUID { get set }

    /// Triggers when error occurs
    var onError: ((Error) -> Void)? { get set }

    /// Fetches and processes the loan list
    func fetchLoans() async

    /// Refreshes and processes the loan list
    func refreshLoans() async

    /// Triggers when logout button tapped on view controller
    func logoButtonTapped() async

    /// Triggers when alert produced
    func presentAlert(_ alert: UIAlertController)
}
