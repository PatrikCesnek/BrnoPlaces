//
//  Place.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import Foundation
import SwiftData
import MapKit

@Model
final class Place: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var placeDescription: String?
    var address: String?
    var latitude: Double
    var longitude: Double
    var createdAt: Date
    var imageURL: String?
    var url: String?
    var isFavorite: Bool = false

    init(
        id: UUID = UUID(),
        name: String = "",
        placeDescription: String? = nil,
        address: String? = nil,
        latitude: Double = 0,
        longitude: Double = 0,
        createdAt: Date = .now,
        imageURL: String? = nil,
        url: String? = nil,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.placeDescription = placeDescription
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.imageURL = imageURL
        self.url = url
        self.isFavorite = isFavorite
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func distance(to coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        CLLocation(latitude: latitude, longitude: longitude)
            .distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
}
