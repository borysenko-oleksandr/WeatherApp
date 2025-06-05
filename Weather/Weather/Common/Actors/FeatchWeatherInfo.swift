//
//  FeatchWeatherInfo.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 09.02.2025.
//

import Foundation

actor FeatchWeatherInfo {
    func getWeatherBy(cityName: String) async throws -> WeatherInfo {
        do {
            let result = try await APIService.shared.httpRequest(
                urlString: "\(API.baseURL.rawValue)/weather?q=\(cityName)&appid=\(API.weatherApiKey.rawValue)&units=metric",
                methods: .Get,
                responseType: WeatherInfo.self
            )
            
            return result
        } catch {
            debugPrint("Error during fetch weather by cityName")
            throw APIError.requestFailed
        }
    }
    
    func getWeatherBy(coordinates: Coordinates) async throws -> WeatherInfo {
        do {
            let result = try await APIService.shared.httpRequest(
                urlString: "\(API.baseURL.rawValue)/weather?lat=\(coordinates.lat)&lon=\(coordinates.long)&appid=\(API.weatherApiKey.rawValue)&units=metric",
                methods: .Get,
                responseType: WeatherInfo.self
            )
            
            return result
        } catch {
            debugPrint("Error during fetch weather by coordinates")
            throw APIError.requestFailed
        }
    }
}
