//
//  CollegeFootballResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/20/23.
//

import Foundation

typealias CollegeFootballResponse = [CollegeFootballGame]
typealias CollegeFootballMediaResponse = [CollegeFootballMedia]

struct CollegeFootballGame: Codable, Identifiable {
    let id: Int
    let start_date: Date
    let venue: String
    let home_id: Int
    let home_team: String
    let home_points: Int
    let away_id: Int
    let away_team: String
    let away_points: Int
}

struct CollegeFootballMedia: Codable, Identifiable {
    let id: Int
    let season: Int
    let startTime: String
    let outlet: String
}
