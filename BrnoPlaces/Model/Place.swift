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
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        subtitle: String? = nil,
        latitude: Double,
        longitude: Double,
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.subtitle = subtitle
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Place {
    static func from(feature: MKGeoJSONFeature) -> Place? {
        guard
            let point = feature.geometry.first as? MKPointAnnotation ?? feature.geometry.first,
            let propertiesData = feature.properties,
            let properties = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any]
        else {
            return nil
        }

        let name = properties["name"] as? String ?? "Unnamed"
        let subtitle = properties["subtitle"] as? String

        return Place(
            name: name,
            subtitle: subtitle,
            latitude: point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
    }
}
