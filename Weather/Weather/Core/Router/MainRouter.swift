//
//  ContentView.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 27.01.2025.
//

import SwiftUI

struct MainRouter: View {
    @StateObject var viewModel = MainRouterViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
        }
        .onAppear {
            viewModel.handleInitialScreen()
        }
    }
}

#Preview {
    MainRouter()
}
