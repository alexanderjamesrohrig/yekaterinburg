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
    @State private var showCalcio: Bool = true
    @State private var showBaseball: Bool = true
    @State private var showBasketball: Bool = true
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "SettingsView")
    
    var body: some View {
        Form {
            Stepper("Baseball team #\(baseballTeam)", value: $baseballTeam)
                .monospacedDigit()
            Stepper("Basketball team #\(basketballTeam)", value: $basketballTeam)
                .monospacedDigit()
            Stepper("Soccer team #\(calcioTeam)", value: $calcioTeam)
                .monospacedDigit()
            Text("Hockey coming soon...")
            Text("Football coming soon...")
            Button("View Notices") {
            // TODO: Show API copyright notices
            }
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
