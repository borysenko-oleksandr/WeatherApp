//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 21.02.2025.
//

import Foundation
import SwiftUI

@MainActor
class WeatherDetailsViewModel: ObservableObject {
    @Published var weatherDetailsList: [WeatherDetailsListItem] = []
    @Published var weatherDetailsCity: WeatherDetailsCity?
    
    var fetchWeatherDetailsService = FetchWeatherDetails()
    
    func getWeatherDetails(coordinates: Coordinates) async {
        do {
            let result = try await fetchWeatherDetailsService.getWeatherDetailsBy(coordinates: coordinates)
            guard let city = result.city, let list = result.list else {
                debugPrint("Missing data in result")
                return
            }
            
            weatherDetailsList = filterWeatherAtNineAM(list: list)
            weatherDetailsCity = city
            
        } catch {
            debugPrint("Error during fetching weather details", error)
        }
    }
    
    func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let formattedDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "dd.MM"
            return dateFormatter.string(from: formattedDate)
        }
        
        return ""
    }
}

private extension WeatherDetailsViewModel {
    func filterWeatherAtNineAM(list: [WeatherDetailsListItem]) -> [WeatherDetailsListItem] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return list.filter { entry in
            if let date = dateFormatter.date(from: entry.dt_txt) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                return hour == 9
            }
            return false
        }
    }
}
