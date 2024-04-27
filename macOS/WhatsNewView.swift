//
//  WhatsNewView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/26/24.
//

import SwiftUI

struct WhatsNewView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("What's new")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
            Text(GeneralSecretary.shared.appName)
            ScrollView {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "figure.baseball")
                    VStack(alignment: .leading) {
                        Text("Baseball schedule and channel listing")
                            .font(.headline)
                        Text("Choose a favorite team in Settings to see their schedule and channel listing.")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    WhatsNewView()
}
