//
//  PlaceMapViewModel.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import SwiftUI
import SwiftData
import MapKit

@MainActor
final class PlaceMapViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var isShowingDetail: Bool = false
    @Published var selectedPlace: Place?
    @Published var error: String?
    
    private let locationManager = CLLocationManager()

    func loadPlaces(modelContext: ModelContext) {
        requestLocation()
        Task {
            await loadPlacesAsync(modelContext: modelContext)
        }
    }
    
    func selectPlace(_ place: Place) {
        selectedPlace = place
        isShowingDetail.toggle()
    }

    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .fitness
        locationManager.startUpdatingLocation()

        if let userLocation = locationManager.location?.coordinate {
            updateUserLocation(userLocation)
        } else {
            updateUserLocation(nil)
        }
    }

    private func updateUserLocation(_ location: CLLocationCoordinate2D?) {
        let regionCenter = location ?? Mock.mockLocation
        cameraPosition = .region(MKCoordinateRegion(
            center: regionCenter,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        ))
    }

    private func loadPlacesAsync(modelContext: ModelContext) async {
        do {
            var fetchedPlaces = try modelContext.fetch(FetchDescriptor<Place>())

            if fetchedPlaces.isEmpty {
                let parsedPlaces = try await GeoJSONParser.loadPlaces()
                for place in parsedPlaces {
                    modelContext.insert(place)
                }
                try modelContext.save()
                fetchedPlaces = parsedPlaces
            }

            await MainActor.run {
                self.places = fetchedPlaces
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
}

