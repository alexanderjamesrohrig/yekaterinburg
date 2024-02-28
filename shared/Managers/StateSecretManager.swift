//
//  StateSecretManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation
import OSLog

class StateSecretManager {
    static let shared = StateSecretManager()
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "StateSecretManager")
    var footballDataToken: String {
        Bundle.main.infoDictionary?["TOKEN_FOOTBALL"] as? String ?? ""
    }
    var ballDontLieToken: String {
        Bundle.main.infoDictionary?["TOKEN_BDL"] as? String ?? ""
    }
    var collegefootballdataToken: String {
        let token = Bundle.main.infoDictionary?["TOKEN_CFD"] as? String ?? ""
        return "Bearer \(token)"
    }
    private init() {}
}
