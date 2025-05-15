//
//  SortOption.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 13/05/2025.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case closest
    case alphabetical
    
    var id: String { rawValue }
    
    var label: String {
        switch self {
        case .closest: return Constants.Strings.closest
        case .alphabetical: return Constants.Strings.aToZ
        }
    }
}
