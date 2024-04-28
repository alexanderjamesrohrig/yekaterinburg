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
    @AppStorage(FeatureFlagManager.shared.appStorageFF1) private var ff1 = false
    @AppStorage(FeatureFlagManager.shared.appStorageFF2) private var ff2 = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(GeneralSecretary.shared.appVersion)
            Toggle("USE_MOCK_DATA", isOn: $useMockData)
            Text("FEATURE_FLAGS:")
            Toggle(FeatureFlagManager.shared.titleFF1, isOn: $ff1)
            Toggle(FeatureFlagManager.shared.titleFF2, isOn: $ff2)
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
