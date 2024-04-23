//
//  SettingsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI
import OSLog

struct SettingsView: View {
    @AppStorage(StoreManager.shared.appStorageBaseball) var baseballTeam: Int = 117
    @AppStorage(StoreManager.shared.appStorageCF) var collegeFootballTeam: Int = 249
    @AppStorage(StoreManager.shared.appStorageBasketball) var basketballTeam: Int = 20
    @AppStorage(StoreManager.shared.appStorageHockey) var hockeyTeam: Int = 3
    @AppStorage(StoreManager.shared.appStorageCalcio) var calcioTeam: Int = 113
    @State private var showCalcio = true
    @State private var showBaseball = true
    @State private var showBasketball = true
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "SettingsView")
    
    var body: some View {
        Form {
            HStack {
                Stepper("Baseball", value: $baseballTeam)
                Image("mlb\(baseballTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("#\(baseballTeam)")
                    .monospaced()
            }
            HStack {
                Stepper("Basketball", value: $basketballTeam)
                Image("nba\(basketballTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("#\(basketballTeam)")
                    .monospaced()
            }
            HStack {
                Stepper("Soccer", value: $calcioTeam)
                Image("fd\(calcioTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("#\(calcioTeam)")
                    .monospaced()
            }
            LabeledContent("Hockey", value: "Coming soon")
            LabeledContent("Football", value: "Coming soon")
            #if DEBUG
            Button("PRINT_FAVORITE_VALUES") {
                logger.info("Favorites: \(baseballTeam) \(basketballTeam) \(calcioTeam)")
            }
            #endif
            RohrigView()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
