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
            if let error = viewModel.error {
                ErrorView(
                    errorString: error,
                    retryAction: {
                        viewModel.loadPlaces(modelContext: modelContext)
                    }
                )
            } else {
                List {
                    Section(
                        header: SortPickerView(sortOption: $viewModel.sortOption)
                    ) {
                        ForEach(viewModel.filteredPlaces) { place in
                            ListRowView(
                                place: place,
                                isFavorite: place.isFavorite,
                                openDetailAction: { place in
                                    viewModel.selectPlace(place)
                                },
                                toggleFavoriteAction: { place in
                                    viewModel.toggleFavorite(for: place)
                                }
                            )
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
        .toolbar{
            FavoriteButtonView(
                showFavoritesAction: {
                    viewModel.isShowingFavourites.toggle()
                },
                isShowingFavourites: viewModel.isShowingFavourites
            )
        }
    }
}

#Preview {
    NavigationStack {
        PlaceListView()
    }
}
