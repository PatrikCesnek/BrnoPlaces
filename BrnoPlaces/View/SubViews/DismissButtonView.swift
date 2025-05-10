//
//  BackButtonView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import SwiftUI

struct DismissButtonView: View {
    private let action : () -> Void
    private let buttonColor: Color
    
    init(
        action: @escaping () -> Void,
        buttonColor: Color = .red
    ) {
        self.action = action
        self.buttonColor = buttonColor
    }
    
    var body: some View {
        Button(
            action: action,
            label: {
                Image(systemName: Constants.Images.dismissButton)
                    .resizable()
                    .foregroundStyle(buttonColor)
                    .shadow(radius: 2)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(buttonColor, lineWidth: 4)
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
