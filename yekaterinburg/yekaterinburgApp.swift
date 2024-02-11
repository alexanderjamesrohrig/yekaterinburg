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
            #if os(macOS)
            SportCollectionMac()
                .frame(minWidth: 700, minHeight: 400)
            #elseif os(iOS)
            ContentViewiOS()
            #elseif os(tvOS)
            ContentViewForTV()
            #else
            ContentView()
            #endif
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
