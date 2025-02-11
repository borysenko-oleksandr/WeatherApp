//
//  SegmentController.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 01.02.2025.
//

import SwiftUI

enum SegmentControllerOptions: String, CaseIterable {
    case searchByCityName = "By city name"
    case searchByCoordinates = "By coordinates"
}

struct SegmentController: View {
    @Binding var selectedSegment: SegmentControllerOptions
    
    var handleChange: () -> Void
    
    var body: some View {
        Picker("Select Option", selection: $selectedSegment) {
            ForEach(SegmentControllerOptions.allCases, id: \.self) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedSegment) {
            handleChange()
        }
        .padding()
        

    }
}

#Preview {
    @Previewable @State var selectedSegment: SegmentControllerOptions = .searchByCityName
    
    SegmentController(selectedSegment: $selectedSegment) {
        
    }
}
