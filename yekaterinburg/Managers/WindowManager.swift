//
//  WindowManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/6/24.
//

import Foundation

class WindowManager {
    static let shared = WindowManager()
    /// Schedule window
    let schedule = "schedule"
    /// Teams window
    let teams = "teams"
    /// Soccer competitions window
    let competitions = "competitions"
    /// Standings window
    let standings = "standings"
    private init() {}
}
