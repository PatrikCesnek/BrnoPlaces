//
//  Date+extensions.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 12/05/2025.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        self.formatted(date: .long, time: .shortened)
    }
}
