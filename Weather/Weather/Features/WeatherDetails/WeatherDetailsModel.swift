//
//  File.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 21.02.2025.
//

import Foundation

struct WeatherDetails: Decodable {
    var city: WeatherDetailsCity?
    var list: [WeatherDetailsListItem]?
}

struct WeatherDetailsListItem: Decodable {
    var dt_txt: String
    var main: WeatherInfoDetailsMain
    var weather: [WeatherInfoDetails]
}

struct WeatherDetailsCity: Decodable {
    var id: Int
    var name: String
}

struct WeatherInfoDetailsMain: Decodable {
    var humidity: Double
    var pressure: Double
    var temp: Double
}
