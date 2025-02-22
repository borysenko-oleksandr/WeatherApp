//
//  WeatherApp.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 27.01.2025.
//

import SwiftUI
import Lottie

@main
struct WeatherApp: App {
    @State private var isReady = false
    
    var body: some Scene {
        WindowGroup {
            if isReady {
                MainRouter()
            } else {
                LottieView(animation: .named("launchScreen"))
                    .playing()
                    .animationDidFinish { _ in
                        isReady = true
                    }
            }
        }
    }
}
