//
//  StringManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/12/24.
//

import Foundation

class StringManager {
    static let shared = StringManager()
    let baseballPrefix = "mlb"
    let basketballPrefix = "nba"
    let hockeyPrefix = "nhl"
    let soccerPrefix = "MLS"
    let storageFFMockData = "storage.ff.mockData"
    let debugViewTitle = "DEBUG"
    private init() {}
}
