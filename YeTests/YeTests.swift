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
    private let logger = Logger(subsystem: "com.alexanderrohrig.YeTests", category: "YeTests")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
}
