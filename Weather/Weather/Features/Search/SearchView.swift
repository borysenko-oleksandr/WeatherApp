//
//  Home.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            Label("Find your place", systemImage: "location.magnifyingglass")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, Styles.horizontalPadding.rawValue)
                .font(.title3)
            
            
            SegmentController(selectedSegment: $viewModel.selectedSegment) {
                viewModel.cleanState()
            }
            
            ZStack {
                if viewModel.selectedSegment == .searchByCityName {
                    SearchByName(cityName: $viewModel.cityName, onSubmit: { text in
                        viewModel.cityName = text
                    })
                    .transition(.opacity)
                } else if viewModel.selectedSegment == .searchByCoordinates {
                    SearchByCoordinates(
                        longitude: $viewModel.coordinates.long,
                        latitude: $viewModel.coordinates.lat,
                        latitudeSubmit: { lat in
                            viewModel.coordinates.lat = lat
                            
                        },
                        longitudeSubmit: { long in
                            viewModel.coordinates.long = long
                        }
                    )
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.25), value: viewModel.selectedSegment)
            
    
            WeatherContentView(
                card: $viewModel.weatherInfo,
                loading: $viewModel.loading
            ) { city in
                viewModel.handlePressPlusButton(city: city)
            }
                .padding(.horizontal, 20)
                .padding(.top, 30)
            
            Spacer()
            
            SubmitButton(title: "Find") {
                await viewModel.handlePressButton()
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .padding(.top)
        .padding(.bottom, 20)
    }
}

#Preview {
    SearchView()
}
