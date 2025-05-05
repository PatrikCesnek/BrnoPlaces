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
        guard let point = feature.geometry.first as? MKPointAnnotation else {
            return nil
        }

        guard let propsData = feature.properties,
              let json = try? JSONSerialization.jsonObject(with: propsData) as? [String: Any] else {
            return nil
        }

        let name = json[Constants.strings.name] as? String ?? Constants.strings.unknown
        let subtitle = json[Constants.strings.description] as? String

        return Place(
            name: name,
            subtitle: subtitle,
            latitude: point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
    }
}
