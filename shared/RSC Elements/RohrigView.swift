//
//  RohrigView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import SwiftUI

struct RohrigView: View {
    var body: some View {
        #if os(tvOS)
        Text(GeneralSecretary.shared.companyName)
        Text(GeneralSecretary.shared.companyLocation)
        #else
        Link(GeneralSecretary.shared.companyName, destination: Rohrig.URL_HTTPS)
        #endif
        Text(GeneralSecretary.shared.copyright)
    }
}
