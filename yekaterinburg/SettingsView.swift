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
            if FFM.shared.ff6.enabled {
                LabeledContent(SM.shared.hockeyLabel, value: SM.shared.comingSoon)
                LabeledContent(SM.shared.basketballLabel, value: SM.shared.comingSoon)
            }
        }
        .padding()
        RohrigView()
            .padding()
    }
}

#Preview {
    SettingsView()
}
