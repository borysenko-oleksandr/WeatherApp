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
        VStack {
            Label("Your favorit places", systemImage: "location.magnifyingglass")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, Styles.horizontalPadding.rawValue)
                .font(.title3)
                .padding(.top)
            
            ScrollView {
                ForEach(viewModel.cards, id: \.name) { info in
                    HStack {
                        WeatherCard(
                            country: info.sys.country,
                            city: info.name,
                            weatherCondition: info.weather[0].main,
                            temperature: info.main.temp,
                            weatherIcon: info.weather[0].icon
                        )
                        
                        Text("")
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding()
                            .background {
                                Circle()
                                    .fill(.primary1)
                                    .padding(6)
                                Image(systemName: "minus")
                                    .symbolVariant(.fill)
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.title)
                            }
                            .onTapGesture {
                                Task {
                                    CoreDataService.shared.removeFavoriteBy(id: info.id)
                                    viewModel.fetchData()
                                }
                            }
                    }
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
            }
            
        }.onAppear {
            Task {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    HomeView()
}
