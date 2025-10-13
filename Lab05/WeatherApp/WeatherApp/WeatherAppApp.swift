//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainWeatherView() // ez lesz az induló "view". innentől a ContentView kb nem is kell
        }
    }
}
