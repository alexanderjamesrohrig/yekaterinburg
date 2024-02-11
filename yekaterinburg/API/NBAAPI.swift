//
//  NBAAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/23/23.
//

import Foundation

struct NBAAPI {
    static let season = 2023
    
    static func games() -> [BasketballResponse.BBallGame] {
        let url = Bundle.main.url(forResource: "balldontlie", withExtension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let data = try Data(contentsOf: url!)
            let decoded = try decoder.decode(BasketballResponse.self, from: data)
            return decoded.data
        } catch {
            return []
        }
    }
}
