//
//  KLColor.swift
//  KliqLoanApp
//
//  Created by Çağatay Eğilmez on 13.07.2026.
//

import SwiftUI

private enum Palette {

    static let navy = Color(red: 0.13, green: 0.17, blue: 0.27)
    static let ink = Color(red: 0.15, green: 0.15, blue: 0.20)
    static let mist = Color(red: 0.95, green: 0.95, blue: 0.97)
    static let whiteScrim = Color.white.opacity(0.85)
    static let lightGray = Color(red: 2.0 / 3.0, green: 2.0 / 3.0, blue: 2.0 / 3.0)
    static let darkGray = Color(red: 1.0 / 3.0, green: 1.0 / 3.0, blue: 1.0 / 3.0)
    static let green = Color(red: 0.18, green: 0.72, blue: 0.45)
    static let orange = Color(red: 0.95, green: 0.62, blue: 0.15)
    static let red = Color(red: 0.90, green: 0.22, blue: 0.21)
    static let gray = Color(red: 0.55, green: 0.55, blue: 0.58)
    static let blue = Color(red: 0.16, green: 0.50, blue: 0.73)
    static let teal = Color(red: 0.20, green: 0.60, blue: 0.56)
    static let brown = Color(red: 0.58, green: 0.34, blue: 0.14)
    static let systemGray = Color(red: 0.5, green: 0.5, blue: 0.5)
}

/// Color palette of project
public enum KLColor {

    /// Primary brand color
    public static let brandPrimary = Palette.navy
    /// App background color
    public static let background = Palette.mist
    /// Dark surface color
    public static let surfaceDark = Palette.navy
    /// Light surface color
    public static let overlayLight = Palette.whiteScrim
    /// Border color
    public static let border = Palette.lightGray
    /// Primary tet color
    public static let textPrimary = Palette.ink
    /// Secondary text color
    public static let textSecondary = Palette.gray
    /// Success green
    public static let success = Palette.green
    /// Warning orange
    public static let warning = Palette.orange
    /// Danger red
    public static let danger = Palette.red
    /// Neautral gray
    public static let neutral = Palette.gray
    /// Passive gray
    public static let statusFallback = Palette.darkGray
    /// Accent indigo color
    public static let accentIndigo = Palette.navy
    /// Accent blue color
    public static let accentBlue = Palette.blue
    /// Accent teal color
    public static let accentTeal = Palette.teal
    /// Accent brown color
    public static let accentBrown = Palette.brown
    /// Accent passive color
    public static let accentFallback = Palette.systemGray
}
