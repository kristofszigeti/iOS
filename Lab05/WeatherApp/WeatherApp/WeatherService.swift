//
//  WeatherService.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

class WeatherService: ObservableObject {
    private let apiKey = "bca2158d50917f4bff437fd617e3fbe3"

    @Published var currentWeather: CurrentWeatherData?
    @Published var forecastData: ForecastData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchWeather(for city: String) async {
        guard let url = URL(string:
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        ) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.currentWeather = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
        } catch {
            print("Error decoding: \(error)")
        }
    }

    func fetchForecast(for city: String) async {
        guard let url = URL(string:
            "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        ) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.forecastData = try JSONDecoder().decode(ForecastData.self, from: data)
        } catch {
            print("Error decoding: \(error)")
        }
    }
}

