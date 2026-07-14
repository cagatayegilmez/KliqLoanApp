//
//  LoadState.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

public enum LoadState: Sendable, Equatable {

    /// Non processing type
    case idle

    /// Data loading type
    case loading

    /// Data loaded type
    case loaded

    /// Data loading failed type
    case failed
}
