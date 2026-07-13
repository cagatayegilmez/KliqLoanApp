//
//  LoginFeatureViewModel.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class LoginFeatureViewModel: LoginFeatureViewModelProtocol {

    @ObservationIgnored
    private let router: any LoginFeatureRoutingProtocol

    init(router: any LoginFeatureRoutingProtocol) {
        self.router = router
    }
}
