//
//  StringManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/12/24.
//

import Foundation

/// String Manager for user facing strings
public typealias SM = StringManager
/// Manager for user facing strings
public class StringManager {
    static let shared = StringManager()
    let baseballPrefix = "mlb"
    let basketballPrefix = "nba"
    let hockeyPrefix = "nhl"
    let soccerPrefix = "MLS"
    let worldFootballPrefix = "fd"
    let storageFFMockData = "storage.ff.mockData"
    let debugViewTitle = "DEBUG"
    let standingsTitle = "Standings"
    let favoriteTeamsSectionTitle = "Favorite teams:"
    let comingSoon = "Coming soon"
    let footballLabel = "Football"
    let hockeyLabel = "Hockey"
    let baseballLabel = "Baseball"
    let basketballLabel = "Basketball"
    let soccerLabel = "Soccer"
    let eventLabel = "Event"
    let unknownLabel = "Unknown"
    let at = " at "
    let updated = "Updated"
    let settingsButtonTitle = "Settings"
    let openAppleNewsButtonTitle = "Open Apple News"
    let refreshButtonTitle = "Refresh"
    let idColumnName = "Id"
    let nameColumnName = "Name"
    let parentOrgColumnName = "Parent organization"
    let sportColumnName = "Sport"
    let or = " or "
    let teamsWindowTitle = "Teams"
    let whatsNewWindowTitle = "What's new"
    let noGamesText = "No games to show, check back later."
    let whatsNew1_1_0Title = "Baseball schedule and channel listing"
    let whatsNew1_1_0Body = "Choose a favorite team in Settings to see their schedule and where to watch the games."
    private init() {}
}