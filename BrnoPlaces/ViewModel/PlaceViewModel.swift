//
//  PlaceViewModel.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import Foundation
import SwiftData

@MainActor
final class PlaceListViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var searchText: String = ""
    @Published var isShowingDetail = false
    
    var filteredPlaces: [Place] {
        guard !searchText.isEmpty else { return places }

        return places.filter { place in
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
                print("Failed to load or seed places: \(error)")
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
            print("Failed to delete place: \(error.localizedDescription)")
        }
    }
    
    func selectPlace(_ place: Place) {
        selectedPlace = place
        isShowingDetail.toggle()
    }
}


