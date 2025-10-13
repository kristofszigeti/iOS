//
//  AddPlaceView.swift
//  BestPlaces
//
//  Created by kristof on 2025. 10. 09..
//

import SwiftUI

struct AddPlaceView: View {
    @Binding var places: [Place]
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var icon = "📍"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Hely adatai") {
                    TextField("Név", text: $name)
                    TextField("Leírás", text: $description)
                    TextField("Emoji", text: $icon)
                }
            }
            .navigationTitle("Új hely")
            .navigationBarItems(
                leading: Button("Mégse") {
                    dismiss()
                },
                trailing: Button("Mentés") {
                    let newPlace = Place(name: name, description: description, icon: icon)
                    places.append(newPlace)
                    dismiss()
                })
            .disabled(name.isEmpty) // üres névvel nem lehet menteni, a többi maradhat üres
        }
    }
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView(places: .constant(
            [Place(name: "name", description: "description", icon: "icon")]))
    }
}
