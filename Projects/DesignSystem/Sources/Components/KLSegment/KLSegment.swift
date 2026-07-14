//
//  KLSegment.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import SwiftUI

public struct KLSegment: View {

    @Binding private var selection: UUID
    private let configuration: KLSegmentConfiguration

    public init(selection: Binding<UUID>,
                configuration: KLSegmentConfiguration) {
        self._selection = selection
        self.configuration = configuration
    }

    public var body: some View {
        Picker("", selection: $selection) {
            ForEach(configuration.segments, id: \.id) { segment in
                Text(segment.title)
                    .tag(segment.id)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
    }
}
