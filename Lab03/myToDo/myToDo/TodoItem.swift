//
//  TodoItem.swift
//  myToDo
//
//  Created by kristof on 2025. 09. 26..
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var isPrior: Bool
}
