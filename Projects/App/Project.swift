//
//  AppProject.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "App",
    bundleIdSuffix: "app",
    hasTests: false,
    dependencies: [
        .module("LoginFeature"),
        .module("HomeFeature")
    ]
)
