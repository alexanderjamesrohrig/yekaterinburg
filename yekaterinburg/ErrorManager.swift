//
//  ErrorManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/20/24.
//

import Foundation
import OSLog

struct Error {
    let id: Int
    let message: String // TODO: Change to OSLogMessage
}

class ErrorManager {
    static let shared = ErrorManager()
    let e1 = Error(id: 1, message: "Unable to create URL")
    let e2 = Error(id: 2, message: "Unable to decode API data")
    private init() {}
}
