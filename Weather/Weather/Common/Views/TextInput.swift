//
//  TextInput.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 29.01.2025.
//

import Foundation
import SwiftUI

enum TextInputStylesVariables: CGFloat {
    case fontSize = 16
    
    case cornerRadius = 17
    case minHeight = 50
    case textInputPadding = 6
    case borderWidht = 1
}


struct TextInput: View {
    
    @Binding var text: String
    
    var onSubmit: (_: String) -> Void
    var placeholder: String = ""
    
    var body: some View {
        Text("\(placeholder):")
            .font(.system(size: TextInputStylesVariables.fontSize.rawValue))
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        
        TextField(placeholder, text: $text)
            .frame(minHeight: TextInputStylesVariables.minHeight.rawValue)
            .padding(.horizontal, TextInputStylesVariables.textInputPadding.rawValue)
                .overlay(
                    RoundedRectangle(cornerRadius: TextInputStylesVariables.cornerRadius.rawValue)
                        .stroke(lineWidth: TextInputStylesVariables.borderWidht.rawValue)
                        .fill(.primary1)
                )
                .textInputAutocapitalization(.words)
                .textEditorStyle(.plain)
                .onSubmit {
                    onSubmit(text)
                }
    }
}


#Preview {
    @Previewable @State var text = ""
    var placeholder = "Template"
    
    TextInput(
        text: $text,
        onSubmit: { text in
            print(text)
        },
        placeholder: placeholder
    )
}

