//
//  PrimaryButtonView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 12/05/2025.
//

import SwiftUI

struct PrimaryButtonView: View {
    private let text: String
    private let action: () -> Void
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    var body: some View {
        Button(
            action: action,
            label: {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        )
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    PrimaryButtonView(
        text: "Action",
        action: {}
    )
}
