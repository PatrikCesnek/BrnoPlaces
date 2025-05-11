//
//  Mock.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 06/05/2025.
//

import Foundation
import MapKit

struct Mock {
    static let mockLocation = CLLocationCoordinate2D(latitude: 16.5699853, longitude: 49.1971106)
    
    static let mockPlace = Place(
        name: "Lorem",
        placeDescription: mockDescription,
        address: "MockAdress2025",
        latitude: mockLocation.latitude,
        longitude: mockLocation.longitude,
        imageURL: "",
        url: "https://www.apple.com"
    )
    
    static let mockDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}
