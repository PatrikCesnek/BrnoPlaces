//
//  DetailMapView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import MapKit
import SwiftUI

struct DetailMapView: View {
    private let latitude: Double
    private let longitude: Double
    private let name: String
    
    init(
        latitude: Double,
        longitude: Double,
        name: String
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    var body: some View {
        Map(
            initialPosition: MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: latitude,
                        longitude: longitude
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01
                    )
                )
            )
        ) {
            Annotation(
                name,
                coordinate: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                )
            ) {
                Image(systemName: Constants.Images.mapPin)
                    .symbolRenderingMode(.multicolor)
                    .imageScale(.large)
            }
        }
    }
}
#Preview {
    let place = Mock.mockPlace
    DetailMapView(
        latitude: place.latitude,
        longitude: place.longitude,
        name: place.name
    )
}
