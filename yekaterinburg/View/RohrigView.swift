//
//  RohrigView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import SwiftUI

struct RohrigView: View {
    var body: some View {
        Link(Rohrig.companyName, destination: Rohrig.url)
        Text(Rohrig.copyright)
    }
}
