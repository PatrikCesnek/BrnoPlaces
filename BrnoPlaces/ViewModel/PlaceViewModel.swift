//
//  PlaceViewModel.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import Foundation
import MapKit
import SwiftData

@MainActor
final class PlaceListViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var searchText: String = ""
    @Published var isShowingDetail = false
    @Published var sortOption: SortOption = .closest
    @Published var isShowingFavourites: Bool = false
    @Published var error: String?
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    var filteredPlaces: [Place] {
        let base = sortedPlaces()

        let favoritesFiltered = isShowingFavourites
            ? base.filter { $0.isFavorite }
            : base

        guard !searchText.isEmpty else { return favoritesFiltered }

        return favoritesFiltered.filter { place in
            place.name.localizedCaseInsensitiveContains(searchText) ||
            (place.address?.localizedCaseInsensitiveContains(searchText) ?? false) ||
            (place.placeDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    func loadPlaces(modelContext: ModelContext) {
        Task {
            do {
                let descriptor = FetchDescriptor<Place>()
                var fetchedPlaces = try modelContext.fetch(descriptor)

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

    func deletePlace(at offsets: IndexSet, modelContext: ModelContext) {
        for index in offsets {
            let place = places[index]
            modelContext.delete(place)
        }

        do {
            try modelContext.save()
            places.remove(atOffsets: offsets)
        } catch {
            self.error = "Failed to delete place: \(error.localizedDescription)"
        }
    }
    
    func toggleFavorite(for place: Place) {
        if let index = places.firstIndex(where: { $0.id == place.id }) {
            places[index].isFavorite.toggle()
        }
    }
    
    func selectPlace(_ place: Place) {
        selectedPlace = place
        isShowingDetail.toggle()
    }
    
    private func sortedPlaces() -> [Place] {
        switch sortOption {
        case .alphabetical:
            return places.sorted { $0.name < $1.name }
        case .closest:
            guard let location = userLocation else { return places }
            return places.sorted {
                $0.distance(to: location) < $1.distance(to: location)
            }
        }
    }
}


