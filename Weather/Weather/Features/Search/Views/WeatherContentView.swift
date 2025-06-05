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
    
    var handlePressPlusButton: (_: FavoriteCity) -> Void

    
    var body: some View {
        if loading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1)
        } else {
            if let weatherInfo = card {
                HStack {
                    WeatherCard(
                        country: weatherInfo.sys.country,
                        city: weatherInfo.name,
                        weatherCondition: weatherInfo.weather[0].main,
                        temperature: weatherInfo.main.temp,
                        weatherIcon: weatherInfo.weather[0].icon
                    )
                    
                    Text("")
                        .frame(width: 40, height: 40, alignment: .center)
                        .padding()
                        .background {
                            Circle()
                                .fill(.primary1)
                                .padding(6)
                            Image(systemName: "plus")
                                .symbolVariant(.fill)
                                .foregroundColor(.white)
                                .bold()
                                .font(.title)
                        }
                        .onTapGesture {
                            Task {
                                handlePressPlusButton(FavoriteCity(id: weatherInfo.id, name: weatherInfo.name))
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var card: WeatherInfo? = WeatherInfo(
        id: 1,
        name: "Lviv",
        main: WeatherInfoMain(temp: 1, feels_like: 1, temp_min: 1, temp_max: 1),
        weather: [WeatherInfoDetails(id: 1, main: "Clean", icon: "10d")],
        sys: SysDetails(country: "UA", sunrise: 1, sunset: 1)
    )
    @Previewable @State var loading = false
    
    WeatherContentView(
        card: $card,
        loading: $loading,
        handlePressPlusButton: { _ in
            print()
        }
    )
}
