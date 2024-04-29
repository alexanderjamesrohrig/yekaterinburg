//
//  DebugView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/18/24.
//

import SwiftUI
import OSLog

struct DebugView: View {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "DebugView")
    @Binding var useMockData: Bool
    @AppStorage(FeatureFlagManager.shared.ff1.appStorageKey) private var ff1 = false
    @AppStorage(FeatureFlagManager.shared.ff2.appStorageKey) private var ff2 = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(GeneralSecretary.shared.appVersion)
            Toggle("USE_MOCK_DATA", isOn: $useMockData)
            Toggle(FeatureFlagManager.shared.ff1.title, isOn: $ff1)
            Toggle(FeatureFlagManager.shared.ff2.title, isOn: $ff2)
            Button("CLEAR_APP_STORAGE") {
                UserDefaults.standard.removeObject(forKey: FeatureFlagManager.shared.ff1.appStorageKey)
                UserDefaults.standard.removeObject(forKey: FeatureFlagManager.shared.ff2.appStorageKey)
                UserDefaults.standard.removeObject(forKey: StoreManager.shared.appStorageBaseball)
                UserDefaults.standard.removeObject(forKey: StoreManager.shared.appStorageBasketball)
                UserDefaults.standard.removeObject(forKey: StoreManager.shared.appStorageCF)
                UserDefaults.standard.removeObject(forKey: StoreManager.shared.appStorageCalcio)
            }
            Button("PRINT_FAVORITES") {
                if let favs = UserDefaults.standard.data(forKey: StoreManager.shared.appStorageFavorites) {
                    logger.info("\(String(data: favs, encoding: .utf8) ?? "")")
                } else {
                    logger.info("No favorites")
                }
            }
            Divider()
            Button("DISMISS") {
                dismiss()
            }
        }
        .padding()
        .onAppear {
            if useMockData {
                logger.warning("USING MOCK DATA")
            }
        }
    }
}
