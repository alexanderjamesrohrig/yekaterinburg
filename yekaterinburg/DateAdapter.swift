//
//  DateAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation
import OSLog

struct DateAdapter {
    private static let dateFormatter = DateFormatter()
    private static let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "DateAdapter")
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
        
        return dateFormatter.string(from: inputAsDate ?? Date.now)
    }
    /// Translates Date to yyyy-MM-dd String
    static func dateForAPI(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .autoupdatingCurrent
        let today = Date.now
        return dateFormatter.string(from: today)
    }
    /// Translates String (Ex. 2023-07-01T00:05:00Z) to Date
    static func dateFromAPI(date: String) -> Date {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let toDate = dateFormatter.date(from: date)
        return toDate ?? Date.now
    }
    /// Adapted String from ScoreboardV2 response to Date
    /// - Parameter scoreboardV2Response: String in format 2024-05-11T00:00:00
    /// - Returns: Date object
    static func dateFrom(_ scoreboardV2Response: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(abbreviation: "EST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: scoreboardV2Response) ?? Date.now
    }
    /// Returns Date given String ISO (Ex. 2024-02-11T00:48:28Z) date
    static func dateFromISO(date: String) -> Date {
        return dateFromAPI(date: date)
    }
    /// Returns String short formatted date and time given Date
    static func lastUpdateString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: date)
    }
    /// Returns String Yekaterinbug specific formatted date (Ex. Feb 10 (Sat)) given Date
    static func yeFormatString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM d (EEE)"
        return df.string(from: date)
    }
    /// <#Description#>
    /// - Parameter date: <#date description#>
    /// - Returns: <#description#>
    static func yeFormatWithTime(from date: Date) -> String {
        // FIXME: User 24 vs 12 hour setting
        let df = DateFormatter()
        df.dateFormat = "MMM d, HH:MM"
        return df.string(from: date)
    }
    /// Returns Int year from given Date. Defaults to current year.
    static func yearFrom(date: Date = Date.now) -> Int {
        return Calendar.autoupdatingCurrent.component(.year, from: date)
    }
    /// Returns String year written out in words given Date. Defaults to current year.
    static func yearInWordsFrom(year: Int = yearFrom()) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        let writtenYear = numberFormatter.string(from: NSNumber(integerLiteral: year))
        guard let writtenYear = writtenYear else {
            logger.error("Unable to format number in spell out style")
            return ""
        }
        return writtenYear
    }
    /// Translates String (Ex. 2023-07-01) to Date
    static func dateFromShortString(date: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let toDate = dateFormatter.date(from: date)
        return toDate ?? Date.now
    }
    /// Medium date and short time Date Formatter
    static var mediumDateShortTime: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    private init() {}
}
