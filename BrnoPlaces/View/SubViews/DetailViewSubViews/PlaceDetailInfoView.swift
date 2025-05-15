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
    private let createdAt: Date
    
    init(
        title: String,
        text: String?,
        address: String?,
        createdAt: Date
    ) {
        self.title = title
        self.text = text
        self.address = address
        self.createdAt = createdAt
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(Constants.Strings.addedOn + "\(createdAt.formattedDate())")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
                if let address = address {
                    Text(address)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if let text = text, !text.isEmpty {
                    ScrollView {
                        Text(text)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
}

#Preview {
    PlaceDetailInfoView(
        title: Mock.mockPlace.name,
        text: Mock.mockPlace.placeDescription,
        address: Mock.mockPlace.address,
        createdAt: Date()
    )
}
