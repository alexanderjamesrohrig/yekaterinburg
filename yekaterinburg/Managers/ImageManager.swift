//
//  ImageManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/6/24.
//

import Foundation

/// System images used within the app
class ImageManager {
    static let shared = ImageManager()
    /// Used to signify multiple teams
    let teams = "person.2.crop.square.stack"
    /// Used to signify baseball
    let baseball = "figure.baseball"
    /// Used to signify football, college and professional
    let football = "figure.american.football"
    /// Used to signify a teams schedule
    let schedule = "calendar"
    /// Used to signify user can refresh data
    let refresh = "arrow.clockwise"
    /// Used to signify the Sports tab within Apple News
    let appleNews = "sportscourt.fill"
    /// Used to signify manually adding a scheduled game
    let add = "plus"
    /// Used to signify hockey
    let hockey = "figure.hockey"
    private init() {}
}
