//
//  ToolbarStatus.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/6/24.
//

import SwiftUI

struct ToolbarStatus: ToolbarContent {
    
    var text: String
    
    var body: some ToolbarContent {
        #if os(tvOS)
        ToolbarItem(placement: .automatic) {
            Text(text)
                .font(.caption2)
        }
        #else
        ToolbarItem(placement: .status) {
            Text(text)
                .font(.caption2)
        }
        #endif
    }
}
