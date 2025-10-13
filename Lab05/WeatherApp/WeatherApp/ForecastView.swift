//
//  ForecastView.swift
//  WeatherApp
//
//  Created by kristof on 2025. 10. 13..
//

import SwiftUI

struct ForecastView: View {
    let forecast: ForecastData
    
    private var dailyForecasts: [ListItem] {
        forecast.list.filter {
            $0.dt_txt.contains("12:00:00")
        }
        }
    var body: some View {
        List(dailyForecasts) { item in
            HStack {
                VStack {
                    Text(item.dt_txt)
                        .font(.headline)
                    
                    Text("\(Int(item.main.temp))°C")
                        .font(.title3)
                        .bold()
                }
                
                AsyncImage(
                    url: URL(string: "https://openweathermap.org/img/wn/\(item.weather.first?.icon ?? "01d")@2x.png")
                )
                .frame(width: 50, height: 50)
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("5 Day Forecast")
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(forecast: ForecastData(list: [
                ListItem(dt: 1, dt_txt: "2025-10-13 12:00:00",
                         main: Main(temp: 21, feels_like: 20, humidity: 50),
                         weather: [Weather(description: "clear sky", icon: "01d")])
            ]))
    }
}
