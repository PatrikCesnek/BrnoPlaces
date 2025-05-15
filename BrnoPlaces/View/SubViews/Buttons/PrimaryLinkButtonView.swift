//
//  PrimaryLinkButtonView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 12/05/2025.
//

import SwiftUI

struct PrimaryLinkButtonView: View {
    let title: String
    let url: URL

    var body: some View {
        Link(destination: url) {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    PrimaryLinkButtonView(
        title: Constants.Strings.moreInfo,
        url: Mock.safeURL
    )
}
