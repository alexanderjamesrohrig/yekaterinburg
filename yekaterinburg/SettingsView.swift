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
            Section(SM.shared.favoriteTeamsSectionTitle) {
                HStack {
                    Stepper(SM.shared.baseballLabel, value: $baseballTeam)
                    Image("\(SM.shared.baseballPrefix)\(baseballTeam)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("#\(baseballTeam)")
                        .monospaced()
                }
                LabeledContent(SM.shared.basketballLabel, value: SM.shared.comingSoon)
                if FFM.shared.ff5.enabled {
                    HStack {
                        Stepper(SM.shared.basketballLabel, value: $basketballTeam)
                        Image("\(SM.shared.basketballPrefix)\(basketballTeam)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("#\(basketballTeam)")
                            .monospaced()
                    }
                }
                LabeledContent(SM.shared.soccerLabel, value: SM.shared.comingSoon)
                if FFM.shared.ff3.enabled {
                    HStack {
                        Stepper(SM.shared.soccerLabel, value: $calcioTeam)
                        Image("\(SM.shared.worldFootballPrefix)\(calcioTeam)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("#\(calcioTeam)")
                            .monospaced()
                    }
                }
                // TODO: Select favorite hockey team
                LabeledContent(SM.shared.hockeyLabel, value: SM.shared.comingSoon)
                LabeledContent(SM.shared.footballLabel, value: SM.shared.comingSoon)
            }
            RohrigView()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
