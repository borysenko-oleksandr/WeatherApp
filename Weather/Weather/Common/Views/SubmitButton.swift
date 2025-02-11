//
//  SumitButton.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 08.02.2025.
//

import SwiftUI

enum ButtonStylesVariables: CGFloat {
    case cornerRadius = 10
    
    case shadowOpacity = 0.3
    case shadowRadius = 8
    case shadowX = 0
    case shadowY = 2
    
    case bodyPadding = 20
}

struct SubmitButton: View {
    var title: String
    var action: () async -> Void
    
    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.primary1)
                .cornerRadius(ButtonStylesVariables.cornerRadius.rawValue)
                .shadow(
                    color: .primary2.opacity(ButtonStylesVariables.shadowOpacity.rawValue),
                    radius: ButtonStylesVariables.shadowRadius.rawValue,
                    x: ButtonStylesVariables.shadowX.rawValue,
                    y: ButtonStylesVariables.shadowY.rawValue
                )
            
        }
        .padding(.horizontal, ButtonStylesVariables.bodyPadding.rawValue)
    }
}

#Preview {
    SubmitButton(title: "Press Me") {
        print("")
    }
}

