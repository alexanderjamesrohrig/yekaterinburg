//
//  DateAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation

struct DateAdapter {
    
    private static let dateFormatter = DateFormatter()
    
    static func timeFrom(gameDate: String, withDate showing: Bool) -> String {
        // Expecteding gameDate in format 2023-07-01T00:05:00Z
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let inputAsDate = dateFormatter.date(from: gameDate)
        dateFormatter.timeStyle = .short
        if showing {
            dateFormatter.dateStyle = .medium
        }
        else {
            dateFormatter.dateStyle = .none
        }
        dateFormatter.timeZone = .autoupdatingCurrent
        
        return dateFormatter.string(from: inputAsDate ?? Date())
    }
}
