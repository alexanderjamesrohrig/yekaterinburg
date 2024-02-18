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
    
    var body: some View {
        VStack {
            Text("DEBUG_INFORMATION")
            Text(GeneralSecretary.shared.appVersion)
            Toggle("USE_MOCK_DATA", isOn: $useMockData)
        }
        .onAppear {
            if useMockData {
                logger.warning("USING MOCK DATA")
            }
        }
    }
}
