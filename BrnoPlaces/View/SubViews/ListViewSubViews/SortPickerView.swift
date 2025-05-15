//
//  SortPickerView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 13/05/2025.
//

import SwiftUI

struct SortPickerView: View {
    @Binding private var sortOption: SortOption
    
    init(sortOption: Binding<SortOption>) {
        self._sortOption = sortOption
    }
    
    var body: some View {
        Picker(Constants.Strings.sort, selection: $sortOption) {
            ForEach(SortOption.allCases) { option in
                Text(option.label)
                    .tag(option)
                    .accessibilityLabel(Constants.Strings.sortOption)
            }
            .frame(maxWidth: .infinity)
        }
        .pickerStyle(.segmented)
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    @Previewable @State var sortOption: SortOption = .closest
    SortPickerView(sortOption: $sortOption)
}
