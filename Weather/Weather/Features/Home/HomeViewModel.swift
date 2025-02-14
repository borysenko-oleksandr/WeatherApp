//
//  HomeViewModel.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var cards: [WeatherInfo] = []
    
    func fetchData() {
        let cities = CoreDataService.shared.fetchFavoriteCity()
        cards = cities.map { city in
            return CoreDataService.shared.getWeatherInfoBy(name: city.name)!
        }
    }
}
