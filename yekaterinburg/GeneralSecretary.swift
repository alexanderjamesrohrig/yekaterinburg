//
//  GeneralSecretary.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/10/24.
//

import Foundation

class GeneralSecretary {
    static let shared = GeneralSecretary()
    let subsystem = "com.alexanderrohrig.yekaterinburg"
    let appName = "Yekaterinburg"
    let appNickname = "Ye"
    let companyName = "The Rohrig Software Company"
    let companyLocation = "Navy Pier Ct New York"
    let copyright = "Copyright ⅯⅯⅩⅩⅣ"
    let majorVersion: Float = 1.1
    var appVersion: String {
        let dictionary = Bundle.main.infoDictionary
        let version = dictionary?["CFBundleShortVersionString"]
        let _ = dictionary?["CFBundleVersion"]
        return "VERSION_\(version ?? "VERSION UNAVAILABLE")"
    }
    let url = URL(string: "https://www.alexanderrohrig.com/RSC")!
    private init() {}
}
