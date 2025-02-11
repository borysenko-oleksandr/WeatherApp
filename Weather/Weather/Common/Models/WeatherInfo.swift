//
//  WeatherInfo.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 09.02.2025.
//

import Foundation

struct WeatherInfo: Decodable {
    var id: Int
    var name: String
    var main: WeatherInfoMain
    var weather: [WeatherInfoDetails]
    var sys: SysDetails
}

struct WeatherInfoMain: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
}

struct WeatherInfoDetails: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct SysDetails: Decodable {
    var country: String
    var sunrise: Int
    var sunset: Int
}
