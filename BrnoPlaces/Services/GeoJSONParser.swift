//
//  GeoJSONParser.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import Foundation
import MapKit

struct PlaceProperties: Decodable {
    let name: String?
    let text: String?
    let address: String?
    let imageURL: String?
    let url: String?
    
    var placeDescription: String? {
        guard let cleaned = text?
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "\n", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !cleaned.isEmpty
        else { return nil }
        return cleaned
    }
}

enum GeoJSONParser {

    static func loadPlaces() async throws -> [Place] {
        guard let url = Bundle.main.url(forResource: "BrnoPlaces", withExtension: "geojson") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        let decoder = MKGeoJSONDecoder()
        let features = try decoder.decode(data).compactMap { $0 as? MKGeoJSONFeature }

        var places: [Place] = []

        for feature in features {
            guard let point = feature.geometry.first else { continue }

            let coordinate = point.coordinate
            var decodedProps: PlaceProperties?

            if let propsData = feature.properties {
                decodedProps = try? JSONDecoder().decode(PlaceProperties.self, from: propsData)
            }

            let rawAddress = decodedProps?.address?.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanAddress = (rawAddress?.isEmpty == false) ? rawAddress : nil
            
            let rawDescription = decodedProps?.placeDescription?
                .replacingOccurrences(of: "&nbsp;", with: " ")
                .replacingOccurrences(of: "\n", with: " ")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanDescription = (rawDescription?.isEmpty == false) ? rawDescription : nil

            let place = Place()
            place.name = decodedProps?.name ?? "Unnamed"
            place.placeDescription = cleanDescription
            place.address = cleanAddress
            place.latitude = coordinate.latitude
            place.longitude = coordinate.longitude
            place.imageURL = decodedProps?.imageURL
            place.url = decodedProps?.url

            places.append(place)
        }

        return places
    }
}
