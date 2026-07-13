//
//  LoanDataProject.swift
//  KliqLoanApp
//
//  Created Çağatay Eğilmez on 13.07.2026
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "LoanData",
    bundleIdSuffix: "loandata",
    hasResources: true,
    hasTests: true,
    dependencies: [
        .module("Core")
    ]
)
