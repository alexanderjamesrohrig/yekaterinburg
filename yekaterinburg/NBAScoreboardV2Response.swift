//
//  NBAScheduleResponseV2.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 5/11/24.
//

import Foundation

struct NBAScoreboardResponseV2: Decodable {
    let resource: String?
    let resultSets: [ScoreboardV2Results]?
    
    struct ScoreboardV2Results: Decodable {
        let name: String?
        let headers: [String]?
        let rowSet: [GameHeaderRow]?
    }
    
//    struct ResultSets: Decodable {
//        let gameHeader: [GameHeaderRow]?
//        
//        init(from decoder: any Decoder) throws {
//            var values = try decoder.unkeyedContainer()
//            self.gameHeader = try values.decodeIfPresent([GameHeaderRow].self)
//        }
//    }
    
    struct GameHeaderRow: Decodable {
        let gameDateEST: Date?
        let gameSequence: Int?
        let gameID: String?
        let gameStatus: Int?
        let gameStatusText: String?
        let gameCode: String?
        let homeTeamID: Int?
        let awayTeamID: Int?
        let season: String?
        let livePeriod: Int?
        let livePCTime: String?
        let nationalTV: String?
        let homeTV: String?
        let awayTV: String?
        let livePeriodBroadcast: String?
        let arena: String?
        let whStatus: Int?
        let wnbaCommissionerFlag: Int?
        
        init(from decoder: any Decoder) throws {
            var values = try decoder.unkeyedContainer()
            self.gameDateEST = try values.decodeIfPresent(Date.self)
            self.gameSequence = try values.decodeIfPresent(Int.self)
            self.gameID = try values.decodeIfPresent(String.self)
            self.gameStatus = try values.decodeIfPresent(Int.self)
            self.gameStatusText = try values.decodeIfPresent(String.self)
            self.gameCode = try values.decodeIfPresent(String.self)
            self.homeTeamID = try values.decodeIfPresent(Int.self)
            self.awayTeamID = try values.decodeIfPresent(Int.self)
            self.season = try values.decodeIfPresent(String.self)
            self.livePeriod = try values.decodeIfPresent(Int.self)
            self.livePCTime = try values.decodeIfPresent(String.self)
            self.nationalTV = try values.decodeIfPresent(String.self)
            self.homeTV = try values.decodeIfPresent(String.self)
            self.awayTV = try values.decodeIfPresent(String.self)
            self.livePeriodBroadcast = try values.decodeIfPresent(String.self)
            self.arena = try values.decodeIfPresent(String.self)
            self.whStatus = try values.decodeIfPresent(Int.self)
            self.wnbaCommissionerFlag = try values.decodeIfPresent(Int.self)
        }
    }
}

// MARK: QuickType
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scoreboardV2 = try? JSONDecoder().decode(ScoreboardV2.self, from: jsonData)
// MARK: ScoreboardV2
/// Object to parse scoreboardV2 endpoint from NBA stats
/// 
/// Result set 0 is game header
/// - Each game is an array in array
/// 
/// Result set 1 is line score
/// - Each team is array in array, away team then home team continued for each game
struct ScoreboardV2: Codable {
    let resource: String?
    let parameters: Parameters?
    let resultSets: [ResultSet]?
}

// MARK: Parameters
struct Parameters: Codable {
    let gameDate, leagueID: String?
    let dayOffset: JSONNull?

    enum CodingKeys: String, CodingKey {
        case gameDate = "GameDate"
        case leagueID = "LeagueID"
        case dayOffset = "DayOffset"
    }
}

// MARK: ResultSet
struct ResultSet: Codable {
    let name: String?
    let headers: [String]?
    let rowSet: [[RowSet]]?
}

enum RowSet: Codable {
    case double(Double)
    case string(String)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(RowSet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RowSet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
    
    func toString() -> String {
        switch self {
        case .string(let string):
            return string
        default:
            return ""
        }
    }
    
    func toDouble() -> Double {
        switch self {
        case .double(let double):
            return double
        default:
            return 0.0
        }
    }
    
    func toInt() -> Int {
        switch self {
        case .double(let double):
            return Int(double)
        default:
            return 0
        }
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
