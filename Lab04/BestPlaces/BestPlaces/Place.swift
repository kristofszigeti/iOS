//
//  Place.swift
//  BestPlaces
//
//  Created by kristof on 2025. 10. 07..
//

import Foundation
// A Model

struct Place: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var description: String
    var icon: String // SF symbol
}
