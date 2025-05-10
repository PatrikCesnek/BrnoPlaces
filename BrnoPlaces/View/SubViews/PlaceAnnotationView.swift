//
//  PlaceAnnotation.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 08/05/2025.
//

import MapKit
import SwiftUI

struct PlaceAnnotationView: MapContent {
    private let place: Place
    private let action: () -> Void
    
    init(
        place: Place,
        action: @escaping () -> Void
    ) {
        self.place = place
        self.action = action
    }
    
    var body: some MapContent {
        Annotation(
            place.name,
            coordinate: CLLocationCoordinate2D(
                latitude: place.latitude,
                longitude: place.longitude
            )
        ) {
            Image(systemName: Constants.Images.mapPin)
                .symbolRenderingMode(.multicolor)
                .imageScale(.large)
                .onTapGesture {
                    action()
                }
        }
    }
}

#Preview {
    Map {
        PlaceAnnotationView(
            place: Mock.mockPlace,
            action: {}
        )
    }
}
