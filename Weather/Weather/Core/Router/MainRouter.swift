//
//  ContentView.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 27.01.2025.
//

import SwiftUI

struct MainRouter: View {
    @State var selection: Tab = .search
    
    var body: some View {
        TabView(selection: $selection) {
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
            
            SettingsView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape.fill")
                }
                .tag(Tab.setting)
        }
    }
}

#Preview {
    MainRouter()
}
