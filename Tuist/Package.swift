//
//  Package.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//
// swift-tools-version: 6.0

@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "Lottie": .framework
    ]
)
#endif

let package = Package(
    name: "Dependencies",
    dependencies: [
        .package(
            url: "https://github.com/airbnb/lottie-ios.git",
            from: "4.6.0"
        )
    ]
)
