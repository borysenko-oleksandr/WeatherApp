//
//  HomeViewModel.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation
import UIKit
import SwiftUICore

@MainActor
class SearchViewModel: ObservableObject {
    @Published var selectedSegment: SegmentControllerOptions = .searchByCityName
    @Published var cityName: String = ""
    @Published var coordinates: Coordinates = (lat: "", long: "")
    
    @Published var loading: Bool = false
    @Published var weatherInfo: WeatherInfo?
    
    var fetchService = FeatchWeatherInfo()
    
    func handlePressButton() async {
        do {
            loading = true
            if selectedSegment == .searchByCityName {
                await handleSearchBy(cityName: cityName)
            } else {
                await handleSearchBy(coordinates: coordinates)
            }
            loading = false
        }
    }
    
    func cleanState() {
        cityName = ""
        coordinates = (lat: "", long: "")
        weatherInfo = nil
    }
}

// MARK: - Private methods
private extension SearchViewModel {
    func handleSearchBy(cityName: String) async {
        do {
            guard cityName.count > 0 else {
                return
            }
            
           let result = try await fetchService.getWeatherBy(cityName: cityName)
            
            weatherInfo = result
        } catch {
            
        }
    }
    
    func handleSearchBy(coordinates: Coordinates) async {
        do {
            guard coordinates.lat.count > 0 && coordinates.long.count > 0 else {
                return
            }
            
            let result = try await fetchService.getWeatherBy(coordinates: coordinates)
            
            weatherInfo = result
        } catch {
            
        }
    }
}
