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
    let appStorageBaseball = "app_storage_baseball_team"
    let appStorageBasketball = "app_storage_basketball_team"
    let appStorageHockey = "app_storage_hockey_team"
    let appStorageCalcio = "app_storage_calcio_team"
    let appStorageCF = "app_storage_college_football_team"
    private init() {}
}
