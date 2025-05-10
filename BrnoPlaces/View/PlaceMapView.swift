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
    @StateObject private var viewModel = PlaceListViewModel()

    var body: some View {
        Map {
            UserAnnotation()

            ForEach(viewModel.places) { place in
                PlaceAnnotationView(
                    place: place,
                    action: {
                        viewModel.selectedPlace = place
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
        .navigationDestination(
            item: $viewModel.selectedPlace,
            destination: { place in
                PlaceDetailView(place: place)
            }
        )
    }
}

#Preview {
    NavigationStack {
        PlaceMapView()
    }
}
