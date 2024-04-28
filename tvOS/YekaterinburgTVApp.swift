//
//  YekaterinburgTVApp.swift
//  YekaterinburgTV
//
//  Created by Alexander Rohrig on 2/17/24.
//

import SwiftUI
import OSLog

@main
struct YekaterinburgTVApp: App {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "YekaterinburgTVApp")
    // TODO: add keys to TV build env variables
    var body: some Scene {
        WindowGroup {
            tvView()
        }
    }
}
