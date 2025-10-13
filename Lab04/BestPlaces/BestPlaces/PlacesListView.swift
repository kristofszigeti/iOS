//
//  PlacesListView.swift
//  BestPlaces
//
//  Created by kristof on 2025. 10. 07..
//

import SwiftUI

struct PlacesListView: View {
    @State private var places: [Place] = [
        Place(name: "Eiffel-torony", description: "Párizs ikonikus tornya.", icon: "🗼"),
        Place(name: "Szabadság-szobor", description: "Neoklasszicista szobor New York kikötőjében.", icon: "🗽"),
        Place(name: "Kolosszeum", description: "Ovális amfiteátrum Róma központjában.", icon: "🏛")
    ]
    @State private var showingAddPlaceSheet: Bool = false
    
    var body: some View {
        NavigationStack { // ez segít detail view-ra navigálni, de kell link majd hozzá. nélküle nem lenne "stack"
            List(places) { place in // ezért kell az Identifiable protokoll, hogy be tudja járni
                NavigationLink(destination: PlaceDetailView(place: place)) // megnyitja a nézetet, ha rákattintok a Text(place.name) szöveggel
                {
//                  Label(place.icon, systemImage: "")
                    Text(place.icon + place.name + " ez navis")
                }
//                HStack { // nem navigálnak sehova
//                    Text(place.icon)
//                    Text(place.name)
//                }
            }
            .navigationTitle("Kedvenc helyeim") // a List neve
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            print("megnyomtad a plus gombot")
                            showingAddPlaceSheet = true
                        },
                        label: { Image(systemName: "plus") }
                    ) // Button\
                }
            }
            .sheet(isPresented: $showingAddPlaceSheet) {
                AddPlaceView(places: $places)
            }
        }
    }
}

struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesListView()
        }
    }

