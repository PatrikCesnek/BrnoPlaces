//
//  HelperFunctions.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 12/05/2025.
//

import MapKit
import Foundation

struct HelperFunctions {
    static func navigateTo(destination name: String, coordinate: CLLocationCoordinate2D) {
        let destination = MKMapItem(placemark: .init(coordinate: coordinate))
        destination.name = name
        destination.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
