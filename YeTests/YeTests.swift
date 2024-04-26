//
//  YeTests.swift
//  YeTests
//
//  Created by Alexander Rohrig on 4/23/24.
//

import XCTest
import OSLog

final class WorldFootballAPITests: XCTestCase {
    private typealias API = WorldFootballAPI
    
    func testCompetitions() async throws {
        let competitions = await API.competitions(useMockData: true)
        guard let competitions else {
            XCTFail()
            return
        }
        XCTAssert(competitions.count == 177)
        guard let first = competitions.competitions?.first else {
            XCTFail()
            return
        }
        XCTAssert(first.id == 2006)
    }
    
    func testTeams() async throws {
        let teams = await API.teams(useMockData: true)
        guard let teams else {
            XCTFail()
            return
        }
        XCTAssert(teams.count == 50)
        guard let first = teams.teams?.first else {
            XCTFail()
            return
        }
        XCTAssert(first.id == 1)
        XCTAssert(first.name == "1. FC Köln")
    }
    
    func testStandings() async throws {
        let league = "BL1"
        let standings = await API.standings(for: league, useMockData: true)
        guard let standings else {
            XCTFail()
            return
        }
        if let id = standings.competition?.id {
            XCTAssert(standings.competition?.id == 2002)
        } else {
            XCTFail()
        }
        if let matchday = standings.season?.currentMatchday {
            XCTAssert(matchday == 31)
        } else {
            XCTFail()
        }
        if let stage = standings.standings?.first?.stage {
            XCTAssert(stage == "REGULAR_SEASON")
        } else {
            XCTFail()
        }
        if let count = standings.standings?.first?.table?.count {
            XCTAssert(count == 18)
        } else {
            XCTFail()
        }
        if let first = standings.standings?.first?.table?.first?.position {
            XCTAssert(first == 1)
        } else {
            XCTFail()
        }
    }
}

final class BasketballAPITests: XCTestCase {
    private typealias API = NBAAPI
    
    func testTeams() async throws {
        let teams = await API.teams(useMockData: true)
        guard let firstID = teams?.data.first?.id else {
            XCTFail()
            return
        }
        XCTAssert(firstID == 1)
        guard let firstCity = teams?.data.first?.city else {
            XCTFail()
            return
        }
        XCTAssert(firstCity == "Atlanta")
    }
}

final class HockeyAPITests: XCTestCase {
    private typealias API = NHLAPI
    
    func testTeams() async throws {
        let teams = await API.teams(useMockData: true)
        guard let first = teams?.data?.first?.id else {
            XCTFail()
            return
        }
        XCTAssert(first == 1)
        guard let name = teams?.data?.first?.teamCommonName else {
            XCTFail()
            return
        }
        XCTAssert(name == "Canadiens")
        guard let count = teams?.data?.count else {
            XCTFail()
            return
        }
        XCTAssert(count == 39)
    }
}
