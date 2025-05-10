//
//  PlaceInfoView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import SwiftUI

struct PlaceDetailInfoView: View {
    private let title: String
    private let text: String?
    private let address: String?
    
    init(
        title: String,
        text: String?,
        address: String?
    ) {
        self.title = title
        self.text = text
        self.address = address
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let address = address {
                    Text(address)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if let text = text, !text.isEmpty {
                    Text(text)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    PlaceDetailInfoView(
        title: Mock.mockPlace.name,
        text: Mock.mockPlace.placeDescription,
        address: Mock.mockPlace.address
    )
}
