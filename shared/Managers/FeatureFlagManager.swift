//
//  FeatureFlagManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/21/24.
//

import Foundation

class FeatureFlagManager {
    static let shared = FeatureFlagManager()
    private init() {}
    // MARK: FF1
    let appStorageFF1 = "FF1"
    /// Teams from all sources
    let titleFF1 = "TEAMS_FROM_ALL_SOURCES"
    /// Protects change from MLB sourced team list to all API sourced team list
    var teamsFromAllAPISources: Bool {
        UserDefaults.standard.bool(forKey: "FF1")
    }
    // MARK: FF2
    let appStorageFF2 = "FF2"
    /// Print full responses
    let titleFF2 = "PRINT_FULL_RESPONSES"
    /// While on, full API responses will be printed. While off, count of elements in API response will be printed
    var printFullResponses: Bool {
        UserDefaults.standard.bool(forKey: "FF2")
    }
}
