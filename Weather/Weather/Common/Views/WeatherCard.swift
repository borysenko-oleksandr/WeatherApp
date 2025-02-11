//
//  WeatherCard.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 08.02.2025.
//

import SwiftUI

enum WeatherCardStylesVariables: CGFloat {
    case cardSpacer = 8
    
    case regularFontSize = 16
    case titleFontSize = 24
    case mediumFontSize = 20
    
    case imageSize = 50
    case cornerRadius = 22
    
    case cardWidth = 360
    case cardHeight = 120
    case shadowOpacity = 0.3
    
    case shadowRadius = 6
    case shadowX = 0
    case shadowY = 2
    
}


struct WeatherCard: View {
    var country: String
    var city: String
    var weatherCondition: String
    var temperature: Double
    var weatherIcon: String
    
    var body: some View {
        HStack {
            VStack(
                alignment: .leading,
                spacing: WeatherCardStylesVariables.cardSpacer.rawValue
            ) {
                Text(country)
                    .font(
                        .system(
                            size: WeatherCardStylesVariables.regularFontSize.rawValue,
                            weight: .regular
                        )
                    )
                    .foregroundColor(.white)
                
                Text(city)
                    .font(
                        .system(
                            size: WeatherCardStylesVariables.titleFontSize.rawValue,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.white)
                
                Text(weatherCondition)
                    .font(
                        .system(
                            size: WeatherCardStylesVariables.regularFontSize.rawValue,
                            weight: .regular
                        )
                    )
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            VStack {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png"))
                    .frame(
                        width: WeatherCardStylesVariables.imageSize.rawValue,
                        height: WeatherCardStylesVariables.imageSize.rawValue
                    )
                
                    .padding()
                
                Text("\(String(format: "%2.f", temperature))°C")
                    .font(
                        .system(
                            size: WeatherCardStylesVariables.mediumFontSize.rawValue,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(.primary1)
        .cornerRadius(WeatherCardStylesVariables.cornerRadius.rawValue)
        .frame(
            height: WeatherCardStylesVariables.cardHeight.rawValue
        )
        .shadow(
            color: .primary2.opacity(ButtonStylesVariables.shadowOpacity.rawValue),
            radius: ButtonStylesVariables.shadowRadius.rawValue,
            x: ButtonStylesVariables.shadowX.rawValue,
            y: ButtonStylesVariables.shadowY.rawValue
        )
    }
    
}

#Preview {
    var country: String = "United States"
    var city: String = "California"
    var weatherCondition: String = "Clear"
    var temperature: Double = 6
    var weatherIcon: String = "10d"
    
    WeatherCard(
        country: country,
        city: city,
        weatherCondition: weatherCondition,
        temperature: temperature,
        weatherIcon: weatherIcon
    )
}
