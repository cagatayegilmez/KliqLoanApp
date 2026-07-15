//
//  LoginFeatureProject.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "LoginFeature",
    bundleIdSuffix: "login",
    hasTests: true,
    dependencies: [
        .module("Core"),
        .module("DesignSystem")
    ]
)
