//
//  yekaterinburgApp.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

@main
struct yekaterinburgApp: App {
    var body: some Scene {
        WindowGroup {
            macView()
                .frame(minWidth: 500, minHeight: 200)
        }
        #if os(macOS)
        Window("Teams", id: WindowManager.shared.teams) {
            TeamsView()
        }
        Settings {
            SettingsView()
        }
        #endif
    }
}
