//
//  WorldFootballCompetitionsResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/23/24.
//

import Foundation

struct WorldFootballCompetitionsResponse: Codable {
    let count: Int?
    let competitions: [Competition]?
    
    struct Competition: Codable, Identifiable {
        let id: Int
        let name: String?
        let code: String?
        let plan: String?
    }
}
