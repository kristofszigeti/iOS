//
//  PlaceDetailView.swift
//  BestPlaces
//
//  Created by kristof on 2025. 10. 08..
//

import SwiftUI

struct PlaceDetailView: View {
    let place: Place
    
    var body: some View {
        VStack(spacing: 20) {
            Text(place.icon)
                .font(.system(size: 50))
            Text(place.name)
                .font(.largeTitle)
            Text(place.description)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
        }
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: Place(name: "name", description: "description", icon: "🍎"))
    }
}
