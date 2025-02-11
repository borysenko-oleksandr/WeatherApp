//
//  SearchByCoordinates.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 01.02.2025.
//

import SwiftUI

struct SearchByCoordinates: View {
    @Binding var longitude: String
    @Binding var latitude: String
    
    var latitudeSubmit: (_: String) -> Void
    var longitudeSubmit: (_: String) -> Void
    
    var body: some View {
        VStack {
            TextInput(text: $latitude, onSubmit: latitudeSubmit, placeholder: "Latitude")
            
            TextInput(text: $longitude, onSubmit: longitudeSubmit, placeholder: "Longitude")

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Styles.horizontalPadding.rawValue)
    }
}
