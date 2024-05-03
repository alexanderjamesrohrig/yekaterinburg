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
        Window(SM.shared.teamsWindowTitle, id: WindowManager.shared.teams) {
            TeamsView()
        }
        Window(SM.shared.whatsNewWindowTitle, id: WindowManager.shared.whatsNew) {
            WhatsNewView()
                .frame(width: 300, height: 500)
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        // TODO: FF protect
//        Window("Competitions", id: WindowManager.shared.competitions) {
//            CompetitionsView()
//        }
//        Window(SM.shared.standingsTitle, id: WindowManager.shared.standings) {
//            
//        }
        Settings {
            SettingsView()
                .frame(width: 500, height: 500)
        }
        #endif
    }
}
