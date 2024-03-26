//
//  BackgroundView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 3/15/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.blue, .white, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()
        // TODO: gradient animation
    }
}

#Preview {
    BackgroundView()
}
