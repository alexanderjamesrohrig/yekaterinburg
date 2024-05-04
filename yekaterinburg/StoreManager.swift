//
//  StoreManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation
import OSLog

class StoreManager {
    static let shared = StoreManager()
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "StoreManager")
    let appStorageBaseball = "app_storage_baseball_team"
    let appStorageBasketball = "app_storage_basketball_team"
    let appStorageHockey = "app_storage_hockey_team"
    let appStorageCalcio = "app_storage_calcio_team"
    let appStorageCF = "app_storage_college_football_team"
    let appStorageFavorites = "app_storage_favorite_teams"
    let appStorageOpenedAppSinceMajorUpdate = "app_storage_opened_at_version"
    let appStoragePopularEvents = "app_storage_popular_events"
    let appStoragePreferFrench = "app_storage_prefer_french_names"
    private func fileURL(withName name: String = "store") throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false).appendingPathComponent("\(name).data")
    }
    
    let nbaTeams: Set<Team> = [
        Team(id: 1610612737, name: "Atlanta", code: "ATL"),
        Team(id: 1610612738, name: "Boston", code: "BOS"),
        Team(id: 1610612739, name: "Cleveland", code: "CLE"),
        Team(id: 1610612740, name: "New Orleans", code: "NOP"),
        Team(id: 1610612741, name: "Chicago", code: "CHI"),
        Team(id: 1610612742, name: "Dallas", code: "DAL"),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: <#T##Int#>, name: <#T##String#>, code: <#T##String#>),
        Team(id: 1610612756, name: "Phoenix", code: "PHX"),
        Team(id: 1610612755, name: "Philadelphia", code: "PHI"),
        Team(id: 1610612754, name: "Indiana", code: "IND"),
        Team(id: 1610612753, name: "Orlando", code: "ORL"),
        Team(id: 1610612752, name: "New York", code: "NYK"),
        Team(id: 1610612751, name: "Brooklyn", code: "BKN"),
        Team(id: 1610612750, name: "Minnesota", code: "MIN"),
        Team(id: 1610612749, name: "Milwaukee", code: "MIL"),
        Team(id: 1610612748, name: "Miami", code: "MIA"),
        Team(id: 1610612747, name: "Los Angeles Lakers", code: "LAL"),
        Team(id: 1610612746, name: "Los Angeles Clippers", code: "LAC"),
        Team(id: 1610612745, name: "Houston", code: "HOU"),
        Team(id: 1610612744, name: "Golden State", code: "GSW"),
        Team(id: 1610612743, name: "Denver", code: "DEN"),
    ]
    
    teams = [
        
        [1610612756, "PHX", "Suns", 1968, "Phoenix", "Phoenix Suns", "Arizona", []],
        [
            1610612757,
            "POR",
            "Trail Blazers",
            1970,
            "Portland",
            "Portland Trail Blazers",
            "Oregon",
            [1977],
        ],
        [
            1610612758,
            "SAC",
            "Kings",
            1948,
            "Sacramento",
            "Sacramento Kings",
            "California",
            [1951],
        ],
        [
            1610612759,
            "SAS",
            "Spurs",
            1976,
            "San Antonio",
            "San Antonio Spurs",
            "Texas",
            [1999, 2003, 2005, 2007, 2014],
        ],
        [
            1610612760,
            "OKC",
            "Thunder",
            1967,
            "Oklahoma City",
            "Oklahoma City Thunder",
            "Oklahoma",
            [1979],
        ],
        [
            1610612761,
            "TOR",
            "Raptors",
            1995,
            "Toronto",
            "Toronto Raptors",
            "Ontario",
            [2019],
        ],
        [1610612762, "UTA", "Jazz", 1974, "Utah", "Utah Jazz", "Utah", []],
        [
            1610612763,
            "MEM",
            "Grizzlies",
            1995,
            "Memphis",
            "Memphis Grizzlies",
            "Tennessee",
            [],
        ],
        [
            1610612764,
            "WAS",
            "Wizards",
            1961,
            "Washington",
            "Washington Wizards",
            "District of Columbia",
            [1978],
        ],
        [
            1610612765,
            "DET",
            "Pistons",
            1948,
            "Detroit",
            "Detroit Pistons",
            "Michigan",
            [1989, 1990, 2004],
        ],
        [
            1610612766,
            "CHA",
            "Hornets",
            1988,
            "Charlotte",
            "Charlotte Hornets",
            "North Carolina",
            [],
        ],

    /// Loads array of Game objects from user's document directory, games.data
    /// - Returns: Array of Game objects
    func loadGames() async -> [Game] {
        guard let url = try? fileURL(withName: "games") else {
            logger.error("Unable to get URL")
            return []
        }
        guard let data = try? Data(contentsOf: url) else {
            logger.error("Unable to create Data object")
            return []
        }
        guard let games = try? JSONDecoder().decode([Game].self, from: data) else {
            logger.error("Unable to decode JSON")
            return []
        }
        return games
    }
    
    /// Saves array of Game objects to file in user's document directory, games.data
    /// - Parameter games: Array of Game objects to save
    func save(games: [Game]) async {
        guard let data = try? JSONEncoder().encode(games) else {
            logger.error("Unable to encode to JSON")
            return
        }
        guard let outputFile = try? fileURL(withName: "games") else {
            logger.error("Unable to get URL")
            return
        }
        do {
            try data.write(to: outputFile)
        } catch {
            logger.error("Unable to write file")
        }
    }
    
    /// Saves array of Team to user default storage
    /// - Parameter teams: Array of Team
    func saveFavorite(teams: Teams) {
        logger.info("Saving teams...")
        let favoriteTeams = teams.filter({ $0.favorite })
        let encoder = JSONEncoder()
        let favoriteData = try? encoder.encode(favoriteTeams)
        guard let favoriteData else {
            logger.error("Unable to encode favorite teams")
            return
        }
        UserDefaults.standard.set(favoriteData, forKey: StoreManager.shared.appStorageFavorites)
        logger.info("Saved \(favoriteTeams.count) teams")
    }
    
    /// Loads array of Team from user default storage
    /// - Returns: Array of Team
    func loadFavorite() -> Teams {
        logger.info("Loading teams...")
        let favoriteData = UserDefaults.standard.data(forKey: StoreManager.shared.appStorageFavorites)
        guard let favoriteData else {
            logger.info("Unable to find saved favorite teams")
            return []
        }
        let decoder = JSONDecoder()
        let favorites = try? decoder.decode(Teams.self, from: favoriteData)
        guard let favorites else {
            logger.error("Unable to decode favorites teams")
            return []
        }
        logger.info("Found \(favorites.count) teams")
        return favorites
    }
    
    private init() {}
}
