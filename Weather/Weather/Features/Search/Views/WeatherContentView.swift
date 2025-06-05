//
//  WeatherContentView.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 09.02.2025.
//

import SwiftUI

struct WeatherContentView: View {
    @Binding var card: WeatherInfo?
    @Binding var loading: Bool

    var body: some View {
        if loading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1)
        } else {
            if let weatherInfo = card {
                WeatherCard(
                    country: weatherInfo.sys.country,
                    city: weatherInfo.name,
                    weatherCondition: weatherInfo.weather[0].main,
                    temperature: weatherInfo.main.temp,
                    weatherIcon: weatherInfo.weather[0].icon
                )
            } else {
                Text("No data available")
                    .foregroundColor(.gray)
            }
        }
    }
}
