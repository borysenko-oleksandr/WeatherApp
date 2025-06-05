//
//  WeatherDataLoader.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//

import Foundation

@MainActor
class WeatherDataLoader {
    private var fetchService = FetchWeatherInfo()
    
    func getWeatherBy(cityName: String) async -> WeatherInfo? {
        do {
            let savedData = CoreDataService.shared.getWeatherInfoBy(name: cityName)
            
            if let cdWeather = savedData, Date().timeIntervalSince(cdWeather.timeinterval!) < AppConstants.threeHours.rawValue {
                return cdWeather
            } else {
                let result = try await fetchService.getWeatherBy(cityName: cityName)
                CoreDataService.shared.saveWeatherInfo(weatherInfo: result)
                return result
            }
        } catch {
            debugPrint("Error during getting weather data by city name", error)
            return nil
        }
    }
    
    func getWeatherBy(coordinates: Coordinates) async -> WeatherInfo? {
        do {
            let savedData = CoreDataService.shared.getWeatherInfoBy(coordinates: coordinates)
            
            if let cdWeather = savedData, Date().timeIntervalSince(cdWeather.timeinterval!) < AppConstants.threeHours.rawValue {
                return cdWeather
            } else {
                let result = try await fetchService.getWeatherBy(coordinates: coordinates)
                CoreDataService.shared.saveWeatherInfo(weatherInfo: result)
                return result
            }
        } catch {
            debugPrint("Error during getting weather data by coordinates", error)
            return nil
        }
    }
}
