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
            scripts: [.swiftLint],
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
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .appSettings
        )
    }
}

public extension Settings {

    static var moduleSettings: Settings {
        .settings(
            base: [
                "SWIFT_VERSION": .string(Constants.swiftVersion),
                "ENABLE_USER_SCRIPT_SANDBOXING": "NO"
            ]
        )
    }

    static var appSettings: Settings {
        .settings(
            base: [
                "SWIFT_VERSION": .string(Constants.swiftVersion),
                "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
                "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
                "GENERATE_INFOPLIST_FILE": "YES",
                "ENABLE_USER_SCRIPT_SANDBOXING": "NO"
            ]
        )
    }
}

public extension TargetScript {

    static var swiftLint: TargetScript {
        .pre(
            script: #"""
            set -euo pipefail
            if [[ "$(uname -m)" == "arm64" ]]; then
              export PATH="/opt/homebrew/bin:$PATH"
            else
              export PATH="/usr/local/bin:$PATH"
            fi
            ROOT_DIR="${SRCROOT}/../.."
            if command -v swiftlint >/dev/null 2>&1; then
              swiftlint lint --config "${ROOT_DIR}/.swiftlint.yml" "${SRCROOT}/Sources"
            else
              echo "warning: SwiftLint not installed. Run: brew install swiftlint"
            fi
            """#,
            name: "SwiftLint Run Script",
            basedOnDependencyAnalysis: false
        )
    }
}
