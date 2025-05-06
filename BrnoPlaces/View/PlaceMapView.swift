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
                Annotation(
                    place.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: place.latitude,
                        longitude: place.longitude
                    )
                ) {
                    Image(systemName: Constants.Images.mapPin)
                        .symbolRenderingMode(.multicolor)
                        .imageScale(.large)
                }
            }
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
        }
        .navigationTitle(Constants.Strings.map)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            viewModel.loadPlaces(modelContext: modelContext)
        }
    }
}

#Preview {
    NavigationStack {
        PlaceMapView()
    }
}
