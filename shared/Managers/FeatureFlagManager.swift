//
//  FeatureFlagManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/21/24.
//

import Foundation

struct FeatureFlag {
    let title: String
    let enabled: Bool
    let id: Int
    var appStorageKey: String {
        "FF\(id)"
    }
}

public typealias FFM = FeatureFlagManager
public class FeatureFlagManager {
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
    /// Calcio features flag
    let ff3 = FeatureFlag(title: "WORLD_FOOTBALL", enabled: false, id: 3)
    /// Hockey features flag
    let ff4 = FeatureFlag(title: "HOCKEY", enabled: false, id: 4)
    /// Basketball features flag
    let ff5 = FeatureFlag(title: "BASKETBALL", enabled: false, id: 5)
}
