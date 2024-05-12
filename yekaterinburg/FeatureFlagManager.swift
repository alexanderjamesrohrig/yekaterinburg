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
    /// Multiple sources will be queried for TeamsView
    let ff1 = FeatureFlag(title: "TEAMS_FROM_ALL_SOURCES", enabled: true, id: 1)
    /// Full API responses will be printed. While disabled, count of elements in API response will be printed
    let ff2 = FeatureFlag(title: "PRINT_FULL_RESPONSES", enabled: false, id: 2)
    /// Calcio features flag
    let ff3 = FeatureFlag(title: "WORLD_FOOTBALL", enabled: false, id: 3)
    /// Hockey features flag
    let ff4 = FeatureFlag(title: "HOCKEY", enabled: true, id: 4)
    /// Basketball features flag
    let ff5 = FeatureFlag(title: "BASKETBALL", enabled: false, id: 5)
    /// Select multiple favorites feature flag
    let ff6 = FeatureFlag(title: "MULTI_FAVORITE", enabled: true, id: 6)
    /// Show popular events
    let ff7 = FeatureFlag(title: "POPULAR_EVENTS", enabled: false, id: 7)
}
