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
                .accessibilityLabel(Constants.Strings.map)
                
                HStack {
                    Spacer()
                    
                    DismissButtonView(action: {
                        withAnimation {
                            dismiss()
                        }
                    })
                    .accessibilityLabel(Constants.Strings.dismiss)
                }
                .offset(y: -140)
                .padding(8)
            }
            
            // Here I'm considering 2 options, hide the view if image is nil or use default empty image, as seen in this example, let me know which one you'd prefer :)
            RemoteImageView(
                imageURL: place.imageURL,
                size: 200
            )
            .offset(y: -50)
            .frame(height: 40)
            .shadow(radius: 8)
            .padding(.bottom, 16)
            .accessibilityLabel(Constants.Strings.placeImage)
            
            PlaceDetailInfoView(
                title: place.name,
                text: place.placeDescription,
                address: place.address,
                createdAt: place.createdAt
            )
            .padding(16)
            
            HStack {
                if let urlString = place.url, let url = URL(string: urlString) {
                    PrimaryLinkButtonView(
                        title: Constants.Strings.moreInfo,
                        url: url
                    )
                    .accessibilityLabel(Constants.Strings.placeLink)
                    
                    Spacer()
                }
                
                PrimaryButtonView(
                    text: Constants.Strings.navigate,
                    action: {
                        HelperFunctions.navigateTo(
                            destination: place.name,
                            coordinate: place.coordinate
                        )
                    }
                )
                .accessibilityLabel(Constants.Strings.navigateToPlace)
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    PlaceDetailView(place: Mock.mockPlace)
}
