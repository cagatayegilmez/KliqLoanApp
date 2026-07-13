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
    hasTests: false,
    dependencies: [
        .package("Lottie")
    ]
)
