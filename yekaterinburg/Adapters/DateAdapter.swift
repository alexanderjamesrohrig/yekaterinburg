//
//  DateAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation

struct DateAdapter {
    private static let dateFormatter = DateFormatter()
    /// Translates String (Ex. 2023-07-01T00:05:00Z) to formatted date String
    static func timeFrom(gameDate: String, withDate showing: Bool) -> String {
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
    /// Translates Date to yyyy-MM-dd String
    static func dateForAPI(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .autoupdatingCurrent
        let today = Date()
        return dateFormatter.string(from: today)
    }
    /// Translates String (Ex. 2023-07-01T00:05:00Z) to Date
    static func dateFromAPI(date: String) -> Date {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let toDate = dateFormatter.date(from: date)
        return toDate ?? Date()
    }
    
    /// Returns Date given ISO date String
    static func dateFromISO(date: String) -> Date {
        return dateFromAPI(date: date)
    }
    
    /// Returns 
    static func lastUpdateString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: date)
    }
    
    static func YeFormatString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM d (EEE)"
        return df.string(from: date)
    }
}
