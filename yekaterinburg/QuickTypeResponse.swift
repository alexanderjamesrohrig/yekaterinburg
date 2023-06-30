// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let response = try? JSONDecoder().decode(Response.self, from: jsonData)

import Foundation

// MARK: - Response
struct Response: Codable {
    let copyright: String
    let totalItems: Int
    let totalEvents: Int
    let totalGames: Int
    let totalGamesInProgress: Int
    let dates: [DateElement]

    enum CodingKeys: String, CodingKey {
        case copyright
        case totalItems
        case totalEvents
        case totalGames
        case totalGamesInProgress
        case dates
    }
}

// MARK: - DateElement
struct DateElement: Codable, Hashable {
    
    static func == (lhs: DateElement, rhs: DateElement) -> Bool {
        if lhs.date == rhs.date {
            return true
        }
        else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    let date: String
    let totalItems: Int
    let totalEvents: Int
    let totalGames: Int
    let totalGamesInProgress: Int
    let games: [Game]
    let events: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case date
        case totalItems
        case totalEvents
        case totalGames
        case totalGamesInProgress
        case games
        case events
    }
}

// MARK: - Game
struct Game: Codable, Hashable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        if lhs.gamePk == rhs.gamePk {
            return true
        }
        else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(gamePk)
    }
    
    let gamePk: Int
    let link: String
    let gameType: String
    let season: String
    let gameDate: String
    let officialDate: String
    let status: Status
    let teams: Teams
    let venue: Venue
    let content: Content
    let gameNumber: Int
    let publicFacing: Bool
    let doubleHeader: String
    let gamedayType: String
    let tiebreaker: String
    let calendarEventID: String
    let seasonDisplay: String
    let dayNight: String
    let scheduledInnings: Int
    let reverseHomeAwayStatus: Bool
    let inningBreakLength: Int
    let gamesInSeries: Int
    let seriesGameNumber: Int
    let seriesDescription: String
    let recordSource: String
    let ifNecessary: String
    let ifNecessaryDescription: String

    enum CodingKeys: String, CodingKey {
        case gamePk
        case link
        case gameType
        case season
        case gameDate
        case officialDate
        case status
        case teams
        case venue
        case content
        case gameNumber
        case publicFacing
        case doubleHeader
        case gamedayType
        case tiebreaker
        case calendarEventID
        case seasonDisplay
        case dayNight
        case scheduledInnings
        case reverseHomeAwayStatus
        case inningBreakLength
        case gamesInSeries
        case seriesGameNumber
        case seriesDescription
        case recordSource
        case ifNecessary
        case ifNecessaryDescription
    }
}

// MARK: - Content
struct Content: Codable {
    let link: String

    enum CodingKeys: String, CodingKey {
        case link
    }
}

// MARK: - Status
struct Status: Codable {
    let abstractGameState: String
    let codedGameState: String
    let detailedState: String
    let statusCode: String
    let startTimeTBD: Bool
    let abstractGameCode: String

    enum CodingKeys: String, CodingKey {
        case abstractGameState
        case codedGameState
        case detailedState
        case statusCode
        case startTimeTBD
        case abstractGameCode
    }
}

// MARK: - Teams
struct Teams: Codable {
    let away: Away
    let home: Away

    enum CodingKeys: String, CodingKey {
        case away
        case home
    }
}

// MARK: - Away
struct Away: Codable {
    let leagueRecord: LeagueRecord
    let team: Team
    let splitSquad: Bool
    let seriesNumber: Int
    let springLeague: SpringLeague

    enum CodingKeys: String, CodingKey {
        case leagueRecord
        case team
        case splitSquad
        case seriesNumber
        case springLeague
    }
}

// MARK: - LeagueRecord
struct LeagueRecord: Codable {
    let wins: Int
    let losses: Int
    let pct: String

    enum CodingKeys: String, CodingKey {
        case wins
        case losses
        case pct
    }
}

// MARK: - SpringLeague
struct SpringLeague: Codable {
    let id: Int
    let name: String
    let link: String
    let abbreviation: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case link
        case abbreviation
    }
}

// MARK: - Team
struct Team: Codable {
    let springLeague: SpringLeague
    let allStarStatus: String
    let id: Int
    let name: String
    let link: String
    let season: Int
    let venue: Venue
    let springVenue: SpringVenue
    let teamCode: String
    let fileCode: String
    let abbreviation: String
    let teamName: String
    let locationName: String
    let firstYearOfPlay: String
    let league: Venue
    let division: Venue
    let sport: Venue
    let shortName: String
    let franchiseName: String
    let clubName: String
    let active: Bool

    enum CodingKeys: String, CodingKey {
        case springLeague
        case allStarStatus
        case id
        case name
        case link
        case season
        case venue
        case springVenue
        case teamCode
        case fileCode
        case abbreviation
        case teamName
        case locationName
        case firstYearOfPlay
        case league
        case division
        case sport
        case shortName
        case franchiseName
        case clubName
        case active
    }
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int
    let name: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case link
    }
}

// MARK: - SpringVenue
struct SpringVenue: Codable {
    let id: Int
    let link: String

    enum CodingKeys: String, CodingKey {
        case id
        case link
    }
}

// MARK: - Encode/decode helpers

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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
