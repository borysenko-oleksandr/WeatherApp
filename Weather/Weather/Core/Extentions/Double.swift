//
//  Double.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 19.02.2025.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
