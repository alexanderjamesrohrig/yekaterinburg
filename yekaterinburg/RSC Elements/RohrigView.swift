//
//  RohrigView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import SwiftUI

struct RohrigView: View {
    var body: some View {
        Link(Rohrig.COMPANY_NAME, destination: Rohrig.URL_HTTPS)
        Text(Rohrig.COPYRIGHT)
    }
}
