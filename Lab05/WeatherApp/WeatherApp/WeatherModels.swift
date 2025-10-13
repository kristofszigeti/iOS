//
//  WeatherModels.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

struct ForecastData: Codable {
    let list: [ListItem]
}

struct ListItem: Codable, Identifiable {
    var id: Int { dt }
    let dt: Int
    let dt_txt: String
    let main: Main
    let weather: [Weather]
}
