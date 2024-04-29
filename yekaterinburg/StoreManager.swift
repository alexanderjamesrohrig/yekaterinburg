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
    private func fileURL(withName name: String = "store") throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false).appendingPathComponent("\(name).data")
    }
    
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
