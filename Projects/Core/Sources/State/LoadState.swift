//
//  LoadState.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

public enum LoadState<Value: Sendable>: Sendable {

    /// Non processing type
    case idle
    /// Data loading type
    case loading
    /// Data loaded type
    case loaded(Value)
    /// Data loading failed type
    case failed(message: String)

    /// Loaded value
    public var value: Value? {
        guard case .loaded(let value) = self else {
            return nil
        }

        return value
    }

    /// Loading labor is current
    public var isLoading: Bool {
        guard case .loading = self else {
            return false
        }

        return true
    }

    /// Can be read when error message occurs
    public var errorMessage: String? {
        guard case .failed(let message) = self else {
            return nil
        }

        return message
    }
}
