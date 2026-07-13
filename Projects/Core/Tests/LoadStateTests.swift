//
//  LoadStateTests.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

@testable import Core
import Testing

struct LoadStateTests {

    @Test func loadedStateExposesValue() {
        let state = LoadState<[Int]>.loaded([1, 2, 3])

        #expect(state.value == [1, 2, 3])
        #expect(!state.isLoading)
        #expect(state.errorMessage == nil)
    }

    @Test func loadingStateReportsLoading() {
        let state = LoadState<[Int]>.loading

        #expect(state.isLoading)
        #expect(state.value == nil)
    }

    @Test func failedStateExposesMessage() {
        let state = LoadState<[Int]>.failed(message: "Something went wrong")

        #expect(state.errorMessage == "Something went wrong")
        #expect(state.value == nil)
        #expect(!state.isLoading)
    }

    @Test func idleStateExposesNothing() {
        let state = LoadState<[Int]>.idle

        #expect(state.value == nil)
        #expect(state.errorMessage == nil)
        #expect(!state.isLoading)
    }
}
