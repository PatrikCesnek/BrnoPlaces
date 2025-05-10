//
//  PlaceDetailView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import SwiftUI
import MapKit
import SwiftData

struct PlaceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    private let place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    var body: some View {
        VStack {
            ZStack {
                DetailMapView(
                    latitude: place.latitude,
                    longitude: place.longitude,
                    name: place.name
                )
                .frame(height: 300)
                .background(ignoresSafeAreaEdges: [.top, .horizontal])
                
                HStack {
                    Spacer()
                    
                    DismissButtonView(action: { dismiss() })
                }
                .offset(y: -140)
                .padding(8)
            }
            
            PlaceDetailInfoView(
                title: place.name,
                text: place.placeDescription,
                address: place.address
            )
            .padding(16)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        
    }
}

#Preview {
    PlaceDetailView(place: Mock.mockPlace)
}
