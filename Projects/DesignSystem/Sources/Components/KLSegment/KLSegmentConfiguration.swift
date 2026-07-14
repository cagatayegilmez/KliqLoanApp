//
//  KLSegmentConfiguration.swift
//  DesignSystem
//
//  Created by Çağatay Eğilmez on 14.07.2026.
//

import Foundation

public struct KLSegmentItem {

    /// Unique id of segment item
    public let id: UUID
    /// Shown title of segment item
    public let title: String

    public init(id: UUID,
                title: String) {
        self.id = id
        self.title = title
    }
}

public struct KLSegmentConfiguration {

    public let segments: [KLSegmentItem]

    private init(segments: [KLSegmentItem]) {
        self.segments = segments
    }

    /// Creates segment view configuration
    ///
    /// - Parameter segments: List of segment objects
    /// - Returns: A KLSegmentConfiguration object which contains segment items
    public static func segments(_ segments: [KLSegmentItem]) -> Self {
        assert(!segments.isEmpty,
               "KLSegment can not be created without segments.")
        assert(Set(segments.map(\.id)).count == segments.count,
               "KLSegment segment values must be unique.")
        return .init(segments: segments)
    }
}
