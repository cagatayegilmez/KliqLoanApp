//
//  LoanDataError.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import Foundation

public enum LoanDataError: LocalizedError {

    /// Json file not found
    case resourceNotFound(String)
    /// Decoding data has failed
    case decodingFailed(underlying: any Error)

    public var errorDescription: String? {
        switch self {
        case .resourceNotFound(let name):
            return "Could not find the resource “\(name)” in the bundle."
        case .decodingFailed(let underlying):
            return "Failed to decode loan data: \(underlying.localizedDescription)"
        }
    }
}
