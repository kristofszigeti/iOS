//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

struct MainWeatherView: View {
    @StateObject var weatherService = WeatherService()
    @State private var city = "Budapest"
    @State private var showingSearch = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let weather = weatherService.currentWeather {
                    Text(weather.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("\(Int(weather.main.temp))°C")
                        .font(.system(size: 50))
                        .bold()
                    
                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(.title3)
                    
                    AsyncImage(
                        url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")
                    )
                    
                    
                    if let forecast = weatherService.forecastData {
                        NavigationLink("5 Day Forecast") {
                            ForecastView(forecast: forecast)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                } else {
                    ProgressView("Betöltés...")
                }
            }
        }
        .padding()
        .task {
            await weatherService.fetchWeather(for: city)
            await weatherService.fetchForecast(for: city)
        }
        .sheet(isPresented: $showingSearch) {
            CitySearchView(currentCity: $city)
        }
        .onChange(of: city) { newCity in
            Task {
                await weatherService.fetchWeather(for: newCity)
                await weatherService.fetchForecast(for: newCity)
            }
        }
    }
}

struct MainWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainWeatherView()
    }
}
