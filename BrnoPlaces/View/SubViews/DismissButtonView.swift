//
//  BackButtonView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import SwiftUI

struct DismissButtonView: View {
    private let action : () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: Constants.Images.backButton)
                    .resizable()
                    .foregroundStyle(.blue)
                    .shadow(radius: 2)
                    .frame(width: 20, height: 40)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.blue, lineWidth: 4)
                            .frame(width: 50, height: 50)
                    }
                    .shadow(radius: 5)
            }
        )
        .frame(width: 50, height: 50)
    }
}

#Preview {
    DismissButtonView(action: {} )
}
