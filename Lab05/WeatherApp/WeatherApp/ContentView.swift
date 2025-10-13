//
//  ContentView.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var city = "Budapest"
    @State private var showingSearch = false
    
//    let weather = Weather(
//        cityName: "Budapest",
//        temperature: 22,
//        description: "Sunny",
//        iconName: "sun.max.fill"
//    )
    
    
    var body: some View {
        VStack {
            if let weather = weatherService.currentWeather {
                Text(weather.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("\(Int(weather.main.temp))°C")
                    .font(.system(size: 60))
                    .bold()
                
                Text(weather.weather.first?.description.capitalized ?? "")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                AsyncImage(
                    url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")
                )
                .frame(width: 100, height: 100)
                
                //            Text(weather.cityName)
                //                .font(.largeTitle)
                //                .bold()
                //
                //            Text("\(Int(weather.temperature))°C")
                //                .font(.system(size: 60))
                //                .bold()
                //
                //            Text(weather.description)
                //                .font(.title2)
                //                .foregroundColor(.gray)
                //
                //            Image(systemName: weather.iconName)
                //                .font(.system(size: 40))
                //                .foregroundColor(.yellow)
            } else {
                ProgressView("...")
            }
            Button("Keressünk egy várost!") {
                showingSearch = true
            }
        }
        .padding()
        .sheet(isPresented: $showingSearch) {
            CitySearchView(currentCity: $city)
        }
        .task {
            await weatherService.fetchWeather(for: city)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
