//
//  PlaceListView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import SwiftUI
import SwiftData

struct PlaceListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = PlaceListViewModel()

    var body: some View {
        List {
            Section {
                ForEach(viewModel.places) { place in
                    VStack(alignment: .leading) {
                        Text(place.name)
                            .font(.headline)
                        if let subtitle = place.subtitle {
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.deletePlace(at: indexSet, modelContext: modelContext)
                }
            }
        }
        .navigationTitle(Constants.Strings.listTitle)
        .onAppear {
            viewModel.loadPlaces(modelContext: modelContext)
        }
    }
}

#Preview {
    NavigationStack {
        PlaceListView()
    }
}
