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

    init(
        id: UUID = UUID(),
        name: String = "",
        placeDescription: String? = nil,
        address: String? = nil,
        latitude: Double = 0,
        longitude: Double = 0,
        createdAt: Date = .now,
        imageURL: String? = nil
    ) {
        self.id = id
        self.name = name
        self.placeDescription = placeDescription
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.imageURL = imageURL
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Place {
    static func from(feature: MKGeoJSONFeature) -> Place? {
        guard
            let propertiesData = feature.properties,
            let properties = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any]
        else {
            return nil
        }

        guard
            let latitude = properties["latitude"] as? Double,
            let longitude = properties["longitude"] as? Double
        else {
            return nil
        }
        
        guard let address = properties["address"] as? String else {
            return nil
        }

        let name = properties["name"] as? String ?? "Unnamed"
        
        let description = properties["text"] as? String
        let imageURL = properties["image"] as? String

        return Place(
            id: UUID(),
            name: name,
            placeDescription: description,
            address: address,
            latitude: latitude,
            longitude: longitude,
            imageURL: imageURL
        )
    }
}
