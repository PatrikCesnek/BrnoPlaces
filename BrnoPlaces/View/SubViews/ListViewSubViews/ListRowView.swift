//
//  ListRowView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 13/05/2025.
//

import SwiftUI

struct ListRowView: View {
    private let place: Place
    private let isFavorite: Bool
    private let openDetailAction: (Place) -> Void
    private let toggleFavoriteAction: (Place) -> Void
    
    init(
        place: Place,
        isFavorite: Bool,
        openDetailAction: @escaping (Place) -> Void,
        toggleFavoriteAction: @escaping (Place) -> Void
    ) {
        self.place = place
        self.isFavorite = isFavorite
        self.openDetailAction = openDetailAction
        self.toggleFavoriteAction = toggleFavoriteAction
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.headline)
                    .accessibilityLabel(Constants.Strings.placeTitle)
                if let address = place.address {
                    Text(address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel(Constants.Strings.placeAddress)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    openDetailAction(place)
                }
            }
            
            Spacer()
            
            Button(
                action: {
                    toggleFavoriteAction(place)
                },
                label: {
                    Image(
                        systemName: isFavorite
                        ? Constants.Images.heartFill
                        : Constants.Images.heart
                    )
                    .bold()
                }
            )
            .accessibilityLabel(Constants.Strings.toggleFavorite)
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    ListRowView(
        place: Mock.mockPlace,
        isFavorite: Bool.random(),
        openDetailAction: { _ in },
        toggleFavoriteAction: { _ in }
    )
}
