//
//  GeoJSONParser.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import Foundation
import MapKit

enum GeoJSONParser {

    static func loadPlaces(from fileName: String) throws -> [Place] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: Constants.Strings.geoJSONExtension) else {
            throw ParserError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        let features = try decodeFeatures(from: data)

        let places = features.compactMap { feature in
            Place.from(feature: feature)
        }

        return places
    }

    private static func decodeFeatures(from data: Data) throws -> [MKGeoJSONFeature] {
        let decoder = MKGeoJSONDecoder()
        let objects = try decoder.decode(data)
        let features = objects.compactMap { $0 as? MKGeoJSONFeature }
        return features
    }

    enum ParserError: Error {
        case fileNotFound
    }
}
