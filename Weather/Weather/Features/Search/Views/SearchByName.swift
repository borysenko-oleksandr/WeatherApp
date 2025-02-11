//
//  SearchByName.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 01.02.2025.
//

import SwiftUI

struct SearchByName: View {
    @Binding var cityName: String
    var onSubmit: (_: String) -> Void
    
    var body: some View {
        VStack {
            TextInput(
                text: $cityName,
                onSubmit: onSubmit,
                placeholder: "City name"
            )

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Styles.horizontalPadding.rawValue)
    }
    
}
