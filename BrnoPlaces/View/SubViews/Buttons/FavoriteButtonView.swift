//
//  FavoriteButtonView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 13/05/2025.
//

import SwiftUI

struct FavoriteButtonView: View {
    private let showFavoritesAction: () -> Void
    private let isShowingFavourites: Bool
    
    init(
        showFavoritesAction: @escaping () -> Void,
        isShowingFavourites: Bool
    ) {
        self.showFavoritesAction = showFavoritesAction
        self.isShowingFavourites = isShowingFavourites
    }
    
    var body: some View {
        Button(
            action: {
                withAnimation {
                    showFavoritesAction()
                }
            },
            label: {
                Image(
                    systemName: isShowingFavourites
                    ? Constants.Images.heartFill
                    : Constants.Images.heart
                )
                .resizable()
                .frame(width: 32, height: 32)
                .bold()
            }
        )
    }
}

#Preview {
    @Previewable @State var isFavorite = false
    FavoriteButtonView(
        showFavoritesAction: {
            isFavorite.toggle()
        },
        isShowingFavourites: isFavorite
    )
}
