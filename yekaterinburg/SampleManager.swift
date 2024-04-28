//
//  SampleManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import Foundation

class SampleManager {
    static let shared = SampleManager()
    let localEvents = [
        Game(gameID: UUID().hashValue, homeTeam: 20, homeTeamName: "New York", homeTeamCode: "NYR", awayTeamName: "New York Islanders", awayTeamCode: "NYI", date: DateAdapter.dateFromISO(date: "2024-02-18T20:00:00Z"), status: "Scheduled", televisionOptions: "ABC", radioOptions: "ESPN New York", venue: "MetLife Stadium", type: .game(.hockey)),
        Game(gameID: UUID().hashValue, homeTeamName: "Masters Tournament, Round One", date: DateAdapter.dateFromISO(date: "2024-04-11T20:00:00Z"), status: "Scheduled", televisionOptions: "ESPN", venue: "Augusta National Golf Course", type: .event),
        Game(gameID: UUID().hashValue, homeTeamName: "Masters Tournament, Round Two", date: DateAdapter.dateFromISO(date: "2024-04-12T20:00:00Z"), status: "Scheduled", televisionOptions: "ESPN", venue: "Augusta National Golf Course", type: .event),
        Game(gameID: UUID().hashValue, homeTeamName: "Masters Tournament, Round Three", date: DateAdapter.dateFromISO(date: "2024-04-13T20:00:00Z"), status: "Scheduled", televisionOptions: "CBS", venue: "Augusta National Golf Course", type: .event),
        Game(gameID: UUID().hashValue, homeTeamName: "Masters Tournament, Round Four", date: DateAdapter.dateFromISO(date: "2024-04-14T20:00:00Z"), status: "Scheduled", televisionOptions: "CBS", venue: "Augusta National Golf Course", type: .event),
    ]
    private init() {}
}
