//
//  nhle-franchise.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/26/24.
//

import Foundation

struct HockeyFranchiseResponse: Codable {
    let data: [Franchise]?
    
    struct Franchise: Codable, Identifiable {
        let id: Int
        let fullName: String?
        let teamCommonName: String?
        let teamPlaceName: String?
    }
}
