//
//  ToolbarButton.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/6/24.
//

import SwiftUI

/// ToolbarButton by Rohrig Software Company. Toolbar button for use in iOS and macOS. Prefer over Button in ToolbarItem. Uses bottomBar placement on iOS.
/// - Parameters:
///     - action: Closure to be run when button is pressed.
///     - title :- Title of button
///     - systemImage : SF Symbol to show for button
struct ToolbarButton: ToolbarContent {
    
    var action: () -> Void
    var title: String
    var systemImage: String
    var placement: ToolbarItemPlacement = .automatic
    var isSettings: Bool = false
    
    @ViewBuilder var body: some ToolbarContent {
        #if os(macOS)
        if isSettings {
            ToolbarItem {
                EmptyView()
            }
        } else {
            ToolbarItem(placement: placement) {
                Button {
                    self.action()
                } label: {
                    Label(title, systemImage: systemImage)
                }
            }
        }
        #elseif os(iOS)
        ToolbarItem(placement: .bottomBar) {
            Button {
                self.action()
            } label: {
                Label(title, systemImage: systemImage)
            }
        }
        #else
        ToolbarItem {
            Button {
                self.action()
            } label: {
                Label(title, systemImage: systemImage)
            }
        }
        #endif
    }
}
