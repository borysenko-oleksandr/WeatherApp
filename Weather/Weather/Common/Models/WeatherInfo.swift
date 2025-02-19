//
//  WeatherInfo.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 09.02.2025.
//

import Foundation

struct WeatherInfo: Decodable {
    var id: Int64
    var name: String
    var main: WeatherInfoMain
    var weather: [WeatherInfoDetails]
    var sys: SysDetails
    var timeinterval: Date?
    var coord: WeatherCoordinates
}

struct WeatherInfoMain: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
}

struct WeatherInfoDetails: Decodable {
    var id: Int64
    var main: String
    var icon: String
}

struct SysDetails: Decodable {
    var country: String
    var sunrise: Int64
    var sunset: Int64
}

struct WeatherCoordinates: Decodable {
    var lat: Double
    var lon: Double
}
