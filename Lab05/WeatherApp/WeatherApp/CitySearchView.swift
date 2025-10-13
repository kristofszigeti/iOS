//
//  CitySearchView.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

struct CitySearchView: View {
    @Binding var currentCity: String
    @Environment(\.dismiss) var dismiss
    @State private var newCity = ""
    
    var body: some View {
        VStack {
            Text("Keresd meg a városod!")
                .font(.headline)
            
            TextField("Írdd be a városodat", text: $newCity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 50)
            
            Button("Search") {
                currentCity = newCity
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct CitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(currentCity: .constant("Budapest"))
    }
}
