//
//  LoadStateTests.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

@testable import Core
import Testing

struct LoadStateTests {

    @Test func statesAreEqualToThemselves() {
        #expect(LoadState.idle == .idle)
        #expect(LoadState.loading == .loading)
        #expect(LoadState.loaded == .loaded)
        #expect(LoadState.failed == .failed)
    }
}
