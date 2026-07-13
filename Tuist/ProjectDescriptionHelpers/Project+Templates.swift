//
//  Project+Templates.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import ProjectDescription

public extension Project {

    static func framework(
        name: String,
        bundleIdSuffix: String,
        hasResources: Bool = false,
        hasTests: Bool = true,
        dependencies: [TargetDependency] = [],
        testDependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = [
            .framework(
                name: name,
                bundleIdSuffix: bundleIdSuffix,
                hasResources: hasResources,
                dependencies: dependencies
            )
        ]

        if hasTests {
            targets.append(
                .unitTests(
                    for: name,
                    bundleIdSuffix: bundleIdSuffix,
                    dependencies: testDependencies
                )
            )
        }

        return Project(name: name, targets: targets)
    }

    static func app(
        name: String,
        bundleIdSuffix: String,
        hasTests: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = [
            .app(
                name: name,
                bundleIdSuffix: bundleIdSuffix,
                dependencies: dependencies
            )
        ]

        if hasTests {
            targets.append(
                .unitTests(
                    for: name,
                    bundleIdSuffix: bundleIdSuffix
                )
            )
        }

        return Project(name: name, targets: targets)
    }
}
