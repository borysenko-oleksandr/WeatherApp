//
//  WeatherDetails.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 21.02.2025.
//

import SwiftUI
import Charts

struct WeatherDetailsView: View {
    @State var coordinates: Coordinates
    @StateObject var viewModel = WeatherDetailsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.weatherDetailsCity?.name ?? " ")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {

                Chart(viewModel.weatherDetailsList, id: \.dt_txt) { entry in
                    LineMark(
                        x: .value("Day", viewModel.convertDate(date: entry.dt_txt)),
                        y: .value("Temp", entry.main.temp)
                    )
                    .foregroundStyle(.blue)
                }
                .frame(height: 200)
                .padding()
                
                
                Chart(viewModel.weatherDetailsList, id: \.dt_txt) { entry in
                    BarMark(
                        x: .value("Day", viewModel.convertDate(date: entry.dt_txt)),
                        y: .value("Temp", entry.main.temp)
                    )
                    .foregroundStyle(.green)
                }
                .frame(height: 200)
                .padding()
                
                Chart(viewModel.weatherDetailsList, id: \.dt_txt) { entry in
                    SectorMark(angle: .value("Temp", entry.main.temp))
                        .foregroundStyle(by: .value("Day", viewModel.convertDate(date: entry.dt_txt)))
                }
                .frame(width: .infinity, height: 200)
                .padding(.horizontal, 16)
                
            }
        }
        .onAppear {
            Task {
                await viewModel.getWeatherDetails(coordinates: coordinates)
            }
        }
    }
}

#Preview {
    @Previewable @State var coordinates = Coordinates(lat: "50.3", long: "20.3")
    
    WeatherDetailsView(coordinates: coordinates)
}
