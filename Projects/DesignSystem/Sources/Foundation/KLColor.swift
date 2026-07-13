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

public enum KLColor {

    public static let brandPrimary = Palette.navy
    public static let background = Palette.mist
    public static let surfaceDark = Palette.navy
    public static let overlayLight = Palette.whiteScrim
    public static let border = Palette.lightGray
    public static let textPrimary = Palette.ink
    public static let textSecondary = Palette.gray
    public static let success = Palette.green
    public static let warning = Palette.orange
    public static let danger = Palette.red
    public static let neutral = Palette.gray
    public static let statusFallback = Palette.darkGray
    public static let accentIndigo = Palette.navy
    public static let accentBlue = Palette.blue
    public static let accentTeal = Palette.teal
    public static let accentBrown = Palette.brown
    public static let accentFallback = Palette.systemGray
}
