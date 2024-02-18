//
//  SettingsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI

struct SettingsView: View {
    @State var baseballTeam: Int = 117
    @State var collegeFootballTeam: Int = 249
    @State var basketballTeam: Int = 20
    @State var hockeyTeam: Int = 3
    @State var calcioTeam: Int = 3
    @State private var showCalcio: Bool = true
    @State private var showBaseball: Bool = true
    @State private var showBasketball: Bool = true
    
    var body: some View {
        Form {
            Section("Sports") {
                Toggle("Show baseball", isOn: $showBaseball)
                Toggle("Show basketball", isOn: $showBasketball)
                Toggle("Show soccer", isOn: $showCalcio)
            }
            Section("Favorite Teams") {
                if showBaseball {
                    Stepper("Baseball team ID", value: $baseballTeam)
                }
                if showBasketball {
                    Stepper("Basketball team ID", value: $basketballTeam)
                }
                if showCalcio {
                    Stepper("Soccer team ID", value: $calcioTeam)
                }
            }
            Section("App Information") {
                RohrigView()
            }
        }
    }
}

#Preview {
    SettingsView()
}
