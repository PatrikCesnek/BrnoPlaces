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
        VStack {
            List {
                Section(
                    header: SortPickerView(sortOption: $viewModel.sortOption)
                ) {
                    ForEach(viewModel.filteredPlaces) { place in
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                            if let address = place.address {
                                Text(address)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectPlace(place)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deletePlace(at: indexSet, modelContext: modelContext)
                    }
                }
            }
            .searchable(
                text: $viewModel.searchText,
                prompt: Constants.Strings.search
            )
            .navigationTitle(Constants.Strings.listTitle)
            .onAppear {
                viewModel.loadPlaces(modelContext: modelContext)
            }
            .fullScreenCover(isPresented: $viewModel.isShowingDetail) {
                if let place = viewModel.selectedPlace {
                    PlaceDetailView(place: place)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaceListView()
    }
}
