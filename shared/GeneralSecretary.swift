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
    var appVersion: String {
        let dictionary = Bundle.main.infoDictionary
        let version = dictionary?["CFBundleShortVersionString"]
        let build = dictionary?["CFBundleVersion"]
        return "\(version ?? "VERSION UNAVAILABLE")_BUILD_\(build ?? "BUILD UNAVAILABLE")"
    }
    let url = URL(string: "https://www.alexanderrohrig.com/RSC")!
    private init() {}
}
