//
//  SettingsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var baseballTeam: Int
    @Binding var collegeFootballTeam: Int
    @Binding var hockeyTeam: Int
    
    var body: some View {
        #if os(tvOS)
        Text("Team selection coming soon...")
        #else
        Stepper("⚾️ #\(baseballTeam)", value: $baseballTeam)
        Stepper("🏈 #\(collegeFootballTeam)", value: $collegeFootballTeam)
        Stepper("🏒 #\(hockeyTeam)", value: $hockeyTeam)
        Link("Submit issue", destination: URL(string: "https://github.com/alexanderjamesrohrig/yekaterinburg/issues")!)
        #endif
        RohrigView()
    }
}

#Preview {
    SettingsView(baseballTeam: .constant(117), collegeFootballTeam: .constant(249), hockeyTeam: .constant(3))
}
