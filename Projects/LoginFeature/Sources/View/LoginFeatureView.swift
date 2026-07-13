//
//  LoginFeatureView.swift
//  LoginFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import SwiftUI

struct LoginFeatureView: View {

    @State private var viewModel: LoginFeatureViewModel

    init(viewModel: LoginFeatureViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        content
    }

    @ViewBuilder private var content: some View {
        VStack {
        }
    }
}
