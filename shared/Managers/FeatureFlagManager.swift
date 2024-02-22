//
//  FeatureFlagManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/21/24.
//

import Foundation

class FeatureFlagManager {
    static let shared = FeatureFlagManager()
    let appStorageFF1 = "FF1"
    let titleFF1 = "TEAMS_FROM_ALL_SOURCES"
    /// Protects change from MLB sourced team list to all API sourced team list
    var teamsFromAllAPISources: Bool = {
        UserDefaults.standard.bool(forKey: "FF1")
    }()
    private init() {}
}
