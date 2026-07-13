//
//  Target+Factory.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import ProjectDescription

public extension Target {

    static func framework(
        name: String,
        bundleIdSuffix: String,
        hasResources: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        .target(
            name: name,
            destinations: Constants.destinations,
            product: .staticFramework,
            bundleId: Constants.bundleId(bundleIdSuffix),
            deploymentTargets: Constants.deploymentTargets,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: hasResources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: .moduleSettings
        )
    }

    static func unitTests(
        for moduleName: String,
        bundleIdSuffix: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .target(
            name: "\(moduleName)Tests",
            destinations: Constants.destinations,
            product: .unitTests,
            bundleId: Constants.bundleId("\(bundleIdSuffix).tests"),
            deploymentTargets: Constants.deploymentTargets,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: moduleName)] + dependencies,
            settings: .moduleSettings
        )
    }

    static func app(
        name: String,
        bundleIdSuffix: String,
        dependencies: [TargetDependency]
    ) -> Target {
        .target(
            name: name,
            destinations: Constants.destinations,
            product: .app,
            bundleId: Constants.bundleId(bundleIdSuffix),
            deploymentTargets: Constants.deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "KliqLoanApp",
                "UILaunchStoryboardName": "LaunchScreen",
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [
                            [
                                "UISceneConfigurationName": "Default Configuration",
                                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                            ]
                        ]
                    ]
                ]
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies,
            settings: .appSettings
        )
    }
}

public extension Settings {

    static var moduleSettings: Settings {
        .settings(
            base: [
                "SWIFT_VERSION": .string(Constants.swiftVersion)
            ]
        )
    }

    static var appSettings: Settings {
        .settings(
            base: [
                "SWIFT_VERSION": .string(Constants.swiftVersion),
                "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
                "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
                "GENERATE_INFOPLIST_FILE": "YES"
            ]
        )
    }
}
