//
//  MainRouterViewModel.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 13.02.2025.
//

import Foundation
import SwiftUI

class MainRouterViewModel: ObservableObject {
    @Published var selection: Tab = .search
    
    func handleInitialScreen() {
        let favoritData = CoreDataService.shared.fetchFavoriteCity()
        
        if favoritData.isEmpty == false {
            selection = .home
        }
    }
}
