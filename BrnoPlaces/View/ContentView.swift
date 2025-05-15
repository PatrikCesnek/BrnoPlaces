//
//  ContentView.swift
//  BrnoPlaces
//
//  Created by Patrik Cesnek on 05/05/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                PlaceListView()
            }
            .tabItem {
                Label(Constants.Strings.list, systemImage: Constants.Images.listImage)
            }
            
            NavigationStack {
                PlaceMapView()
            }
            .tabItem {
                Label(Constants.Strings.map, systemImage: Constants.Images.map)
            }
        }
    }
}

#Preview {
    ContentView()
}
