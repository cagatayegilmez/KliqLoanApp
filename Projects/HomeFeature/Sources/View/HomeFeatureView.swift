//
//  HomeFeatureView.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import SwiftUI

struct HomeFeatureView: View {

    @State private var viewModel: HomeFeatureViewModel

    init(viewModel: HomeFeatureViewModel) {
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
