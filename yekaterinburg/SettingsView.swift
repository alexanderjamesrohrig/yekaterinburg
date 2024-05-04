//
//  SettingsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI
import OSLog

struct SettingsView: View {
    @AppStorage(StoreManager.shared.appStoragePreferFrench) var preferFrench: Bool = false
    @AppStorage(StoreManager.shared.appStoragePopularEvents) var showPopularEvents: Bool = true
    @AppStorage(StoreManager.shared.appStorageShowNBAGames) var showNBAGames: Bool = true
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "SettingsView")
    
    var body: some View {
        Form {
            if FFM.shared.ff6.enabled {
                if FFM.shared.ff7.enabled {
                    Toggle(SM.shared.showPopularEvents, isOn: $showPopularEvents)
                    Text(SM.shared.showPopularEventsFootnote)
                        .font(.footnote)
                }
                if FFM.shared.ff5.enabled {
                    Toggle(SM.shared.showNBAGames, isOn: $showNBAGames)
                    Text(SM.shared.showNBAGamesFootnote)
                        .font(.footnote)
                } else {
                    LabeledContent(SM.shared.basketballLabel, value: SM.shared.comingSoon)
                }
                if FFM.shared.ff4.enabled {
                    Toggle(SM.shared.preferFrenchTeamNames, isOn: $preferFrench)
                    Text(SM.shared.preferFrenchTeamNamesFootnote)
                        .font(.footnote)
                } else {
                    LabeledContent(SM.shared.hockeyLabel, value: SM.shared.comingSoon)
                }
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
