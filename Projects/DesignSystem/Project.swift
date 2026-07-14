//
//  DesignSystemProject.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "DesignSystem",
    bundleIdSuffix: "designsystem",
    hasResources: true,
    hasTests: false,
    dependencies: [
        .package("Lottie")
    ]
)
