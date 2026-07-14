//
//  Constants.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import ProjectDescription

public enum Constants {

    public static let workspaceName = "KliqLoanApp"
    public static let bundleIdPrefix = "com.cagatayegilmez.kliqloan"
    public static let destinations: Destinations = [.iPhone, .iPad]
    public static let deploymentTargets: DeploymentTargets = .iOS("17.0")
    public static let swiftVersion = "6.0"

    public static func bundleId(_ suffix: String) -> String {
        "\(bundleIdPrefix).\(suffix)"
    }
}

public extension TargetDependency {

    static func module(_ name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Projects/\(name)"))
    }

    static func package(_ name: String) -> TargetDependency {
        .external(name: name)
    }
}
