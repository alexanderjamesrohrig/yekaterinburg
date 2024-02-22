//
//  NavigationView.swift
//  YekaterinburgTV
//
//  Created by Alexander Rohrig on 2/21/24.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        NavigationStack {
            TabView {
                GameListView()
                    .tabItem {
                        Label("Games", systemImage: "scribble")
                    }
            }
        }
    }
}

#Preview {
    NavigationView()
}
