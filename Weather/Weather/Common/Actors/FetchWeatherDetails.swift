//
//  FetchWeatherDetails.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 21.02.2025.
//

import Foundation

actor FetchWeatherDetails {
    func getWeatherDetailsBy(coordinates: Coordinates) async throws -> WeatherDetails {
        do {
            let result = try await APIService.shared.httpRequest(
                urlString: "\(API.baseURL.rawValue)/forecast?lat=\(coordinates.lat)&lon=\(coordinates.long)&appid=\(API.weatherApiKey.rawValue)&units=metric",
                methods: .Get,
                responseType: WeatherDetails.self
            )
            
            return result
        } catch {
            debugPrint("Error during fetch weather by cityName")
            throw APIError.requestFailed
        }
    }
}
