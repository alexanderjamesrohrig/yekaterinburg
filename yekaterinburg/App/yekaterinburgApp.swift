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
            ContentView().frame(minWidth: 700, minHeight: 400)
            #elseif os(iOS)
            ContentViewiOS()
            #else
            ContentView()
            #endif
        }
        #if os(macOS)
        Window("Schedule", id: "sched") {
            ScheduleView()
        }
        Window("Teams", id:"teams") {
            TeamsView()
        }
        #endif
    }
}
