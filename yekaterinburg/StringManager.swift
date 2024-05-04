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
    let manageFavoritesButtonTitle = "Manage favorite teams"
    let favoriteColumnName = "Favorite"
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
    let idColumnName = "ID"
    let nameColumnName = "Name"
    let parentOrgColumnName = "Parent organization"
    let sportColumnName = "Sport"
    let or = " or "
    let teamsWindowTitle = "Teams"
    let whatsNewWindowTitle = "What's new"
    let noGamesText = "No games to show"
    let dismissButtonTitle = "Dismiss"
    let preferFrenchTeamNames = "Prefer french names"
    let preferFrenchTeamNamesFootnote = "When available, team names will be shown in french"
    let showNBAGames = "Show today's NBA games"
    let showNBAGamesFootnote = "All NBA games on TV today will be shown"
    let showPopularEvents = "Show popular events"
    let showPopularEventsFootnote = "Show popular sporting events like The Masters or The US Open"
    // MARK: What's new
    let whatsNew1_1_0Title = "Baseball schedule and channel listing"
    let whatsNew1_1_0Body = "Choose your favorite teams in Window > Teams to see their schedule and where to watch the games."
    private init() {}
}
