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
            Text(SM.shared.whatsNewWindowTitle)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
            Text(GeneralSecretary.shared.appName)
            ScrollView {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: ImageManager.shared.baseball)
                    VStack(alignment: .leading) {
                        Text(SM.shared.whatsNew1_1_0Title)
                            .font(.headline)
                        Text(SM.shared.whatsNew1_1_0Body)
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
