//
//  BasketballTeamsResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/20/24.
//

import Foundation

struct BasketballTeamsResponse: Codable {
    let data: [Team]
    
    struct Team: Codable {
        let id: Int
        let city: String?
        let name: String
        let full_name: String
        let abbreviation: String
    }
}
