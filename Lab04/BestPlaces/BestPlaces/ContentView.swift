//
//  ContentView.swift
//  BestPlaces
//
//  Created by kristof on 2025. 10. 07..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // VStack
        TabView {
            Image(systemName: "applelogo")
            // Text("Helyeim") // a PlaceListView létrehozása után eldobhatjuk
            PlacesListView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Helyek")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profil")
                 }
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
