//
//  HomeFeatureView.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import SwiftUI

struct HomeFeatureView: View {

    @State private var viewModel: HomeFeatureViewModelProtocol
    weak var loader: SwiftUILoaderProtocol?

    init(viewModel: HomeFeatureViewModel,
         loader: SwiftUILoaderProtocol? = nil) {
        _viewModel = State(initialValue: viewModel)
        self.loader = loader
    }

    var body: some View {
        content
            .task {
                await viewModel.fetchLoans()
            }
            .onChange(of: viewModel.viewState) { _, newValue in
                let condition = [.idle, .loading].contains(newValue)
                loader?.toggleLoading(isLoading: condition)
            }
    }

    @ViewBuilder private var content: some View {
        switch viewModel.viewState {
        case .idle:
            Text("Loading...")
        case .loading:
            ProgressView()
        case .loaded:
            KLSegment(selection: $viewModel.selectedSegment,
                      configuration: .segments(viewModel.segments))
        case .failed(let message):
            Text(message)
        }
    }
}
