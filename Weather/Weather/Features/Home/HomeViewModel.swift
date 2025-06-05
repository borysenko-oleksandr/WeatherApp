//
//  HomeViewModel.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var cards: [WeatherInfo] = []
    var fetchService = WeatherDataLoader()
    
    func fetchData() async {
        let cities = CoreDataService.shared.fetchFavoriteCity()
        var results: [WeatherInfo] = []
        
        for city in cities {
            if let weather = await fetchService.getWeatherBy(cityName: city.name) {
                results.append(weather)
            }
        }
        cards = results
    }
}
