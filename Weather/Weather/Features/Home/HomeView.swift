//
//  Home.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Label("Your favorit places", systemImage: "location.magnifyingglass")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, Styles.horizontalPadding.rawValue)
                    .font(.title3)
                    .padding(.top)
                
                ScrollView {
                    ForEach(viewModel.cards, id: \.name) { info in
                        HStack {
                            NavigationLink(destination: WeatherDetailsView(coordinates: Coordinates(lat: String(info.coord.lat), long: String(info.coord.lon)))) {
                                WeatherCard(
                                    country: info.sys.country,
                                    city: info.name,
                                    weatherCondition: info.weather[0].main,
                                    temperature: info.main.temp,
                                    weatherIcon: info.weather[0].icon
                                )
                            }
                        }
                        .padding(.bottom, 24)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                }
            }.onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
