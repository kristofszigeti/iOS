//
//  ContentView.swift
//  myToDo
//
//  Created by kristof on 2025. 09. 26..
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [TodoItem] = [
        TodoItem(title: "SwiftUI gyakorlás", isCompleted: false, isPrior: true),
        TodoItem(title: "Tej", isCompleted: true, isPrior: false),
        TodoItem(title: "Vidd le a szemetet", isCompleted: false, isPrior: false)
    ] // lista a teendők tárolására, és egyből adjunk is hozzá kezdőértékeket //@State állapotváltozó?? <= hogy írjunk és olvassunk egy értéket a SwiftUI-ban
    
    @State private var newTodoTitle: String = "" // az új teendő definiálása, hogy később hozzá tudjuk adni egy beviteli mezőn keresztül
    func addNewTask(_ newTodoTitle: String) {
        if !self.newTodoTitle.isEmpty {
            tasks.append(TodoItem(title: newTodoTitle, isCompleted: false, isPrior: false))
            self.newTodoTitle = ""
        }
    }
    
    func deleteTask(_ offsets: IndexSet) {
        self.tasks.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack { // konténer függőleges elrendezésre
            Text("Teendőim")
                .font(.largeTitle)
                
            List {
                ForEach($tasks) {
                    $task in HStack {
                        if task.isCompleted == true {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("\(task.title)")
                                .strikethrough(true,color: .secondary)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.primary)
                            Text("\(task.title)")
                                .strikethrough(false)
                        }
                    }
                    .onTapGesture {
                        task.isCompleted.toggle() // @State-nek köszönhetően a felület azonnal frissülni fog
                    }
                }
                .onDelete(perform: deleteTask)
            }
            HStack {
                TextField("új teendő", text: $newTodoTitle)
                
                Button {
                    // action
                    addNewTask(newTodoTitle)
                } label: {
                    // text
                    Text("Hozzáad")
                }
                .buttonStyle(.bordered)
            }
            .padding(20)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
