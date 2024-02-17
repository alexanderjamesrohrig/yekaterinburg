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
            // TODO: Implement View System 1
            ContentView()
        }
        #if os(macOS)
        Window("Schedule", id: WindowManager.shared.schedule) {
            ScheduleView()
        }
        Window("Teams", id: WindowManager.shared.teams) {
            TeamsView()
        }
        #endif
    }
}
