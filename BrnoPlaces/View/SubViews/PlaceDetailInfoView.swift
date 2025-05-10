//
//  PlaceInfoView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import SwiftUI

struct PlaceDetailInfoView: View {
    private let title: String
    private let description: String?
    
    init(
        title: String,
        description: String?
    ) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let description = description {
                    Text(description)
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
        description: Mock.mockPlace.subtitle
    )
}
