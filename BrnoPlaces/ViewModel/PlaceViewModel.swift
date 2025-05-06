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

    func loadPlaces(modelContext: ModelContext) {
        Task {
            do {
                let descriptor = FetchDescriptor<Place>()
                var fetchedPlaces = try modelContext.fetch(descriptor)

                if fetchedPlaces.isEmpty {
                    let parsedPlaces = try GeoJSONParser.loadPlaces(from: "BrnoPlaces")
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
}


