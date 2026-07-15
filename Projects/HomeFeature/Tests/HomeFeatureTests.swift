//
//  HomeFeatureTests.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

@testable import HomeFeature
import LoanData
import Testing
import UIKit

private enum Constant {

    static let allSegmentTitle = "All"
    static let activeSegmentTitle = "Active"
    static let activeLoan = Loan(name: "Consumer Credit",
                                 principalAmount: 8500,
                                 interestRate: 2.9,
                                 status: .active,
                                 dueInDays: 45,
                                 type: .personal)
    static let overdueLoan = Loan(name: "Vehicle Credit",
                                  principalAmount: 24000,
                                  interestRate: 4.1,
                                  status: .overdue,
                                  dueInDays: 12,
                                  type: .auto)
    static let paidLoan = Loan(name: "Mortgage Credit",
                               principalAmount: 150000,
                               interestRate: 1.8,
                               status: .paid,
                               dueInDays: 0,
                               type: .mortgage)
}

private struct MockError: Error {}

@MainActor
struct HomeFeatureTests {

    private let mockViewModel: MockHomeFeatureViewModel
    private let sut: any HomeFeatureViewModelProtocol

    init() {
        mockViewModel = MockHomeFeatureViewModel()
        sut = mockViewModel
    }

    @Test
    func fetchLoansSuccessLoadsAllLoans() async {
        mockViewModel.loansToReturn = [Constant.activeLoan,
                                       Constant.overdueLoan,
                                       Constant.paidLoan]

        await sut.fetchLoans()

        #expect(sut.viewState == .loaded)
        #expect(sut.filteredLoans == mockViewModel.loansToReturn)
        #expect(sut.segments.first?.title == Constant.allSegmentTitle)
        #expect(sut.selectedSegment == sut.segments.first?.id)
        #expect(mockViewModel.fetchLoansCallCount == 1)
    }

    @Test
    func fetchLoansFailureSetsFailedStateAndTriggersOnError() async {
        mockViewModel.loadError = MockError()

        var receivedError: (any Error)?
        sut.onError = { receivedError = $0 }

        await sut.fetchLoans()

        #expect(sut.viewState == .failed)
        #expect(receivedError is MockError)
        #expect(sut.filteredLoans.isEmpty)
    }

    @Test
    func fetchLoansCancellationDoesNotTriggerOnError() async {
        mockViewModel.loadError = CancellationError()

        var receivedError: (any Error)?
        sut.onError = { receivedError = $0 }

        await sut.fetchLoans()

        #expect(sut.viewState == .idle)
        #expect(receivedError == nil)
    }

    @Test
    func selectingSegmentFiltersLoansByStatus() async throws {
        mockViewModel.loansToReturn = [Constant.activeLoan,
                                       Constant.overdueLoan,
                                       Constant.paidLoan]

        await sut.fetchLoans()

        let activeSegment = try #require(sut.segments.first {
            $0.title == Constant.activeSegmentTitle
        })
        sut.selectedSegment = activeSegment.id

        #expect(sut.filteredLoans == [Constant.activeLoan])
    }

    @Test
    func refreshLoansKeepsSelectedSegmentFilter() async throws {
        mockViewModel.loansToReturn = [Constant.activeLoan,
                                       Constant.paidLoan]

        await sut.fetchLoans()

        let activeSegment = try #require(sut.segments.first {
            $0.title == Constant.activeSegmentTitle
        })
        sut.selectedSegment = activeSegment.id
        mockViewModel.loansToReturn = [Constant.activeLoan,
                                       Constant.overdueLoan]

        await sut.refreshLoans()

        #expect(sut.filteredLoans == [Constant.activeLoan])
        #expect(mockViewModel.refreshLoansCallCount == 1)
    }

    @Test
    func logoutButtonTappedTracksLogout() async {
        await sut.logoutButtonTapped()

        #expect(mockViewModel.logoutCallCount == 1)
    }

    @Test
    func presentAlertForwardsAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        sut.presentAlert(alert)

        #expect(mockViewModel.presentedAlert === alert)
    }
}
