//
//  ColorManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/10/24.
//

import Foundation
import SwiftUI
import OSLog

class ColorManager {
    static let shared = ColorManager()
    func getGameCardColor(colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .dark:
            #if os(macOS)
            return Color(nsColor: NSColor.darkGray)
            #else
            return Color(UIColor.darkGray)
            #endif
        case .light:
            return Color(lightestGray)
        @unknown default:
            logger.error("Found unknown color scheme")
            return Color.clear
        }
    }
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "ColorManager")
    private let lightestGray = "LightestGray"
    private init() {}
}
