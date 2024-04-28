//
//  TeamsViewModel.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/28/24.
//

import Foundation
import OSLog

class TeamsViewModel: ObservableObject {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "TeamsViewModel")
    @Published var teams: [Team] = []
    @Published var sortOrder = [KeyPathComparator(\Team.sportSpecificID)]
    
    func firstIndex(_ team: Team) -> Int {
        let index = teams.firstIndex { t in
            t.id == team.id
        }
        if let index {
            return index
        } else {
            logger.error("Unable to find index")
            return 0
        }
    }
}
