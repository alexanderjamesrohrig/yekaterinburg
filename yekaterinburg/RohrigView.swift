//
//  RohrigView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import SwiftUI

struct RohrigView: View {
    var body: some View {
        VStack(alignment: .center) {
#if os(tvOS)
            Text(GeneralSecretary.shared.companyName)
                .font(.headline)
#else
            Link(GeneralSecretary.shared.companyName, destination: GeneralSecretary.shared.url)
                .font(.headline)
#endif
            Text(GeneralSecretary.shared.companyLocation)
                .font(.subheadline)
            Text(GeneralSecretary.shared.copyright)
                .font(.caption)
        }
    }
}

#Preview {
    RohrigView()
}
