//
//  ContentView.swift
//  iCalculatorApp
//
//  Created by kristof on 2025. 09. 26..
//

import SwiftUI

struct ContentView: View {
    @State private var operand1: String = ""
    @State private var operand2: String = ""
    @State private var result: String = "'result'"
    @State private var selectedOperation = OperationType.add
    
    // body-n kívül, de a megfelelő view-n belül
    enum OperationType: String, Identifiable, CaseIterable {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "÷"
        
        var id: String {self.rawValue}
    }
    
    var body: some View { // computed body
        VStack {
            Text("iCalculator Pro") // read-only text
                .font(.largeTitle) // modifier methods
                .padding()
//                .border(.blue)
            
            TextField("1st number", text: $operand1) // a nézethez adott szövegmező a szövegdoboz alá és a hozzá csatolt változó
//                .border(.black)
//                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 100)
            
//            Text("+")
//                .fontWeight(.bold)
//                .font(.title2)
            
            Picker("Operation", selection: $selectedOperation)
            {
////                Text("+").tag(0)
//                Text("+").tag(OperationType.add)
////                Text("-").tag(1)
//                Text("-").tag(OperationType.subtract)
////                Text("*").tag(2)
//                Text("*").tag(OperationType.multiply)
////                Text("÷").tag(3)
//                Text("÷").tag(OperationType.divide)
                
                ForEach(OperationType.allCases) {
                    operation in Text(operation.rawValue).tag(operation)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 300, height: 50, alignment: .center)
            .padding()
            .fontWeight(.bold)
            
            TextField("2nd number", text: $operand2) // vezérlő, szerkeszthető szövegbevitelhez: "placeholder", "bound variable"
//                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 100)
            
            Button {
                // action
                if let o1 = Float(operand1), let o2 = Float(operand2)
                {
                    switch(selectedOperation)
                    {
                    case .add:
                        self.result = String(o1 + o2)
                    case .subtract:
                        self.result = String(o1 - o2)
                    case .multiply:
                        self.result = String(o1 * o2)
                    case .divide:
                        self.result = String(o1 / o2)
                    }
                }
            } label: {
                //text
                Text("=")
                    .frame(width: 100, height: 30, alignment: .center)
                    .font(.title)
//                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 1.0))
                    .fontWeight(.bold)
            }
            // gombstílus modifier-ek
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(Color.mint)
            .padding()
            
            Text("\(self.result)")
                .font(.title)
        }
        .textFieldStyle(.roundedBorder) // az egész VStack-re vonatkozik
        .multilineTextAlignment(.center)
        
        Spacer() // mindent középre rendez
    }
    
    struct ContentView_Previews: PreviewProvider { // az előnézetért felelős struct a saját protollja szerint
        static var previews: some View {
            ContentView()
        }
    }
}
