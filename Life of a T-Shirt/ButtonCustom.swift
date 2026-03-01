//
//  ButtonCustom.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-22.
//

import Foundation
import SwiftUI

struct ButtonCustom: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.black)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(
                isEnabled
                ? (configuration.isPressed ? Color.black.opacity(0.8) : .black)
                : Color.gray
            )
            .opacity(isEnabled ? 1 : 0.6)
            .cornerRadius(25)
            .overlay(
                   RoundedRectangle(cornerRadius: 25)
                       .stroke(Color.black, lineWidth: 2)
               )
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeInOut(duration: 0.15), value: isEnabled)
    }
}
