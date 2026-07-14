//
//  HomeFeatureView.swift
//  HomeFeature
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import DesignSystem
import SwiftUI

@MainActor
private enum Constant {

    static let screenSize = UIScreen.main.bounds
    static var vStackInsetsWidth: CGFloat {
        Constant.screenSize.width - .spacing800
    }
    static let logoName = "kliq_logo"
}

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
        case .idle, .loading, .failed:
            Image(Constant.logoName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constant.vStackInsetsWidth,
                       height: .spacing1250)
        case .loaded:
            screenContent()
        }
    }

    @ViewBuilder
    private func screenContent() -> some View {
        VStack {
            // Summary view
            SummaryCard(data: viewModel.summaryCardData)
                .frame(width: Constant.vStackInsetsWidth,
                       height: .spacing2500)
                .padding(.top, .spacing300)

            // Segment view
            KLSegment(selection: $viewModel.selectedSegment,
                      configuration: .segments(viewModel.segments))
            .frame(width: Constant.vStackInsetsWidth,
                   height: .spacing1250)
            .padding(.top, .spacing300)

            
        }
    }
}
