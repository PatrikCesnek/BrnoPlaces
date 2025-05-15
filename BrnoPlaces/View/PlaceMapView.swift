//
//  PlaceMapView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import SwiftUI
import MapKit
import SwiftData

struct PlaceMapView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = PlaceMapViewModel()

    var body: some View {
        if let error = viewModel.error {
            ErrorView(
                errorString: error,
                retryAction: {
                    viewModel.loadPlaces(modelContext: modelContext)
                }
            )
        } else {
            Map {
                UserAnnotation()

                ForEach(viewModel.places) { place in
                    PlaceAnnotationView(
                        place: place,
                        action: {
                            withAnimation {
                                viewModel.selectPlace(place)
                            }
                        }
                    )
                }
            }
            .mapControls {
                MapCompass()
                MapUserLocationButton()
            }
            .onAppear{
                viewModel.loadPlaces(modelContext: modelContext)
            }
            .toolbar(.hidden, for: .navigationBar)
            .fullScreenCover(isPresented: $viewModel.isShowingDetail) {
                if let place = viewModel.selectedPlace {
                    PlaceDetailView(place: place)
                }
            }
            .accessibilityHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        PlaceMapView()
    }
}
