//
//  ErrorView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 13/05/2025.
//

import SwiftUI

struct ErrorView: View {
    private let errorString: String
    private let retryAction: () -> Void
    
    init(
        errorString: String,
        retryAction: @escaping () -> Void
    ) {
        self.errorString = errorString
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: Constants.Images.gearXmark)
                .resizable()
                .frame(width: 80,height: 80)
                .foregroundColor(.red)
                .bold(true)
                .symbolEffect(.rotate)
            
            Text(Constants.Strings.errorTitle)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Text(errorString)
            
            Spacer()
            
            PrimaryButtonView(
                text: Constants.Strings.errorRetry,
                action: retryAction
            )
            .tint(.red)
            .frame(width: 250, height: 50)
            .padding(16)
        }
    }
}

#Preview {
    ErrorView(
        errorString: "Lorem ipsum",
        retryAction: {}
    )
}
